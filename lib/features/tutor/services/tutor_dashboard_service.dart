import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tutor_stats.dart';

class TutorDashboardService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<TutorStats> getTutorStats(String tutorId) async {
    try {
      final DateTime now = DateTime.now();
      final DateTime monthStart = DateTime(now.year, now.month, 1);

      // Get total students
      final studentsQuery =
          await _client.from('students').select('id').eq('tutor_id', tutorId);
      final totalStudents = studentsQuery.length;

      // Get total sessions
      final sessionsQuery = await _client
          .from('class_sessions')
          .select('id')
          .eq('tutor_id', tutorId);
      final totalSessions = sessionsQuery.length;

      // Get upcoming sessions
      final upcomingQuery = await _client
          .from('class_sessions')
          .select('id')
          .eq('tutor_id', tutorId)
          .gt('scheduled_at', now.toIso8601String());
      final upcomingSessions = upcomingQuery.length;

      // Get earnings
      final earningsQuery = await _client
          .from('session_bookings')
          .select('amount')
          .eq('status', 'completed')
          .eq('payment_status', 'paid')
          .in_('session_id', [...sessionsQuery.map((s) => s['id'])]);

      final totalEarnings = earningsQuery.fold<double>(
        0,
        (sum, booking) => sum + (booking['amount'] as num),
      );

      // Get monthly earnings
      final monthlyEarningsQuery = await _client
          .from('session_bookings')
          .select('amount')
          .eq('status', 'completed')
          .eq('payment_status', 'paid')
          .gt('created_at', monthStart.toIso8601String())
          .in_('session_id', [...sessionsQuery.map((s) => s['id'])]);

      final monthlyEarnings = monthlyEarningsQuery.fold<double>(
        0,
        (sum, booking) => sum + (booking['amount'] as num),
      );

      // Get ratings
      final reviewsQuery = await _client
          .from('tutor_reviews')
          .select('rating')
          .eq('tutor_id', tutorId);

      final totalReviews = reviewsQuery.length;
      final averageRating = totalReviews > 0
          ? reviewsQuery.fold<double>(
                0,
                (sum, review) => sum + (review['rating'] as num),
              ) /
              totalReviews
          : 0.0;

      // Get sessions per day for the last week
      final DateTime weekAgo = now.subtract(const Duration(days: 7));
      final weeklySessionsQuery = await _client
          .from('class_sessions')
          .select('scheduled_at')
          .eq('tutor_id', tutorId)
          .gte('scheduled_at', weekAgo.toIso8601String())
          .lte('scheduled_at', now.toIso8601String());

      final Map<String, int> sessionsPerDay = {};
      for (var session in weeklySessionsQuery) {
        final date = DateTime.parse(session['scheduled_at']).toLocal();
        final dateStr = '${date.year}-${date.month}-${date.day}';
        sessionsPerDay[dateStr] = (sessionsPerDay[dateStr] ?? 0) + 1;
      }

      return TutorStats(
        totalStudents: totalStudents,
        totalSessions: totalSessions,
        upcomingSessions: upcomingSessions,
        totalEarnings: totalEarnings,
        monthlyEarnings: monthlyEarnings,
        averageRating: averageRating,
        totalReviews: totalReviews,
        sessionsPerDay: sessionsPerDay,
      );
    } catch (e) {
      throw 'Failed to get tutor stats: ${e.toString()}';
    }
  }

  Stream<double> streamTutorEarnings(String tutorId) {
    return _client
        .from('session_bookings')
        .stream(primaryKey: ['id'])
        .eq('status', 'completed')
        .eq('payment_status', 'paid')
        .map((bookings) => bookings.fold<double>(
              0,
              (sum, booking) => sum + (booking['amount'] as num),
            ));
  }

  Stream<int> streamUpcomingSessionsCount(String tutorId) {
    return _client
        .from('class_sessions')
        .stream(primaryKey: ['id'])
        .eq('tutor_id', tutorId)
        .gt('scheduled_at', DateTime.now().toIso8601String())
        .map((sessions) => sessions.length);
  }

  Stream<List<String>> streamActiveStudents(String tutorId) {
    return _client
        .from('students')
        .stream(primaryKey: ['id'])
        .eq('tutor_id', tutorId)
        .map((students) => students.map((s) => s['id'] as String).toList());
  }
}
