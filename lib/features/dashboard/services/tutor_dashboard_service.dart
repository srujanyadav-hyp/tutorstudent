import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tutor_stats.dart';

final tutorDashboardServiceProvider =
    Provider((ref) => TutorDashboardService());

class TutorDashboardService {
  final _supabase = Supabase.instance.client;

  Future<TutorStats> getTutorStats(String tutorId) async {
    try {
      final DateTime now = DateTime.now();
      final DateTime monthStart = DateTime(now.year, now.month, 1);

      // Get total sessions and calculate metrics
      final sessionsQuery = await _supabase
          .from('sessions')
          .select('id, created_at, amount')
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

      // Process all sessions
      for (final session in sessions) {
        final amount = (session['amount'] as num).toDouble();
        totalEarnings += amount;

        final sessionDate = DateTime.parse(session['created_at']);
        if (sessionDate.isAfter(monthStart)) {
          monthlyEarnings += amount;
        }

        // Update daily metrics for the last 7 days
        final daysAgo = now.difference(sessionDate).inDays;
        if (daysAgo <= 6) {
          final dateStr =
              '${sessionDate.year}-${sessionDate.month}-${sessionDate.day}';
          sessionsPerDay[dateStr] = (sessionsPerDay[dateStr] ?? 0) + 1;

          final index = 6 - daysAgo;
          if (index >= 0 && index < 7) {
            sessionMetrics[index] = SessionMetric(
                date: sessionMetrics[index].date,
                sessionCount: (sessionMetrics[index].sessionCount + 1));
            earningMetrics[index] = EarningMetric(
                date: earningMetrics[index].date,
                amount: (earningMetrics[index].amount + amount));
          }
        }
      }

      // Get upcoming sessions
      final upcomingSessionsRes = await _supabase
          .from('sessions')
          .select()
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
                  0, (sum, review) => sum + (review['rating'] as num)) /
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
