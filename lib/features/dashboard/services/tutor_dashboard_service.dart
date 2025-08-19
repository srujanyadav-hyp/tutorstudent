import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../tutor/models/tutor_stats.dart';

final tutorDashboardServiceProvider = Provider(
  (ref) => TutorDashboardService(),
);

class TutorDashboardService {
  final _supabase = Supabase.instance.client;

  Future<TutorStats> getTutorStats(String tutorId) async {
    try {
      final DateTime now = DateTime.now();
      final DateTime monthStart = DateTime(now.year, now.month, 1);

      // 1) Sessions for this tutor (class_sessions)
      final sessionsQuery = await _supabase
          .from('class_sessions')
          .select('id, created_at')
          .eq('tutor_id', tutorId);

      final sessions = sessionsQuery as List;

      // Calculate total earnings
      double totalEarnings = 0;
      double monthlyEarnings = 0;

      // Track sessions per day and earnings
      final Map<String, int> sessionsPerDay = {};
      final sessionMetrics = <SessionMetric>[];
      final earningMetrics = <EarningMetric>[];

      // Initialize the last 7 days with zero counts
      for (int i = 6; i >= 0; i--) {
        final date = DateTime(now.year, now.month, now.day - i);
        final dateStr = '${date.year}-${date.month}-${date.day}';
        sessionsPerDay[dateStr] = 0;
        sessionMetrics.add(SessionMetric(date: date, sessionCount: 0));
        earningMetrics.add(EarningMetric(date: date, amount: 0));
      }

      // Process all sessions for session counts (no amounts here)
      for (final session in sessions) {
        final sessionDate = DateTime.parse(session['created_at'] as String);

        // Update daily metrics for the last 7 days
        final daysAgo = now.difference(sessionDate).inDays;
        if (daysAgo <= 6) {
          final dateStr =
              '${sessionDate.year}-${sessionDate.month}-${sessionDate.day}';
          sessionsPerDay[dateStr] = (sessionsPerDay[dateStr] ?? 0) + 1;

          final index = 6 - daysAgo;
          if (index >= 0 && index < 7) {
            sessionMetrics[index] = sessionMetrics[index].copyWith(
              sessionCount: sessionMetrics[index].sessionCount + 1,
            );
          }
        }
      }

      // 2) Paid bookings for earnings (session_bookings)
      final bookingsQuery = await _supabase
          .from('session_bookings')
          .select('amount, created_at')
          .eq('tutor_id', tutorId)
          .eq('payment_status', 'paid');

      final bookings = bookingsQuery as List;

      for (final booking in bookings) {
        final amount = (booking['amount'] as num?)?.toDouble() ?? 0.0;
        totalEarnings += amount;

        final createdAt = DateTime.parse(booking['created_at'] as String);
        if (createdAt.isAfter(monthStart)) {
          monthlyEarnings += amount;
        }

        // Update earning metrics for the last 7 days
        final daysAgo = now.difference(createdAt).inDays;
        if (daysAgo <= 6) {
          final index = 6 - daysAgo;
          if (index >= 0 && index < 7) {
            earningMetrics[index] = earningMetrics[index].copyWith(
              amount: earningMetrics[index].amount + amount,
            );
          }
        }
      }

      // Get upcoming sessions
      final upcomingSessionsRes = await _supabase
          .from('class_sessions')
          .select('id')
          .eq('tutor_id', tutorId)
          .gt('scheduled_at', now.toIso8601String());
      final upcomingSessions = (upcomingSessionsRes as List).length;

      // Get total students
      final studentsQuery = await _supabase
          .from('student_tutor_connections')
          .select()
          .eq('tutor_id', tutorId)
          .eq('status', 'active');
      final totalStudents = (studentsQuery as List).length;

      // Get ratings
      final reviewsQuery = await _supabase
          .from('tutor_reviews')
          .select('rating')
          .eq('tutor_id', tutorId);

      final reviews = reviewsQuery as List;
      final totalReviews = reviews.length;
      final averageRating = totalReviews > 0
          ? reviews.fold<double>(
                  0,
                  (sum, review) => sum + (review['rating'] as num),
                ) /
                totalReviews
          : 0.0;

      return TutorStats(
        totalSessions: sessions.length,
        totalEarnings: totalEarnings,
        upcomingSessions: upcomingSessions,
        totalStudents: totalStudents,
        monthlyEarnings: monthlyEarnings,
        averageRating: averageRating,
        totalReviews: totalReviews,
        sessionsPerDay: sessionsPerDay,
        sessionMetrics: sessionMetrics,
        earningMetrics: earningMetrics,
      );
    } catch (e) {
      throw Exception('Failed to get tutor stats: ${e.toString()}');
    }
  }
}
