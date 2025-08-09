import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tutor_stats.dart';

class TutorDashboardService {
  final _supabase = Supabase.instance.client;

  Future<TutorStats> getTutorStats(String tutorId) async {
    try {
      final response = await _supabase.rpc(
        'get_tutor_stats',
        params: {'p_tutor_id': tutorId},
      );

      return TutorStats.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw 'Failed to get tutor stats: ${e.toString()}';
    }
  }

  Stream<double> streamTutorEarnings(String tutorId) {
    return _supabase
        .from('session_payments')
        .stream(primaryKey: ['id'])
        .eq('tutor_id', tutorId)
        .map(
          (records) => records
              .map((record) => (record['amount'] as num).toDouble())
              .fold(0.0, (sum, amount) => sum + amount),
        );
  }

  Stream<int> streamUpcomingSessionsCount(String tutorId) {
    final now = DateTime.now();
    return _supabase
        .from('class_sessions')
        .stream(primaryKey: ['id'])
        .eq('tutor_id', tutorId)
        .map(
          (records) => records
              .where(
                (record) => DateTime.parse(
                  record['scheduled_at'] as String,
                ).isAfter(now),
              )
              .length,
        );
  }

  Stream<List<String>> streamActiveStudents(String tutorId) {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return _supabase
        .from('student_tutor_connections')
        .stream(primaryKey: ['id'])
        .eq('tutor_id', tutorId)
        .map(
          (records) => records
              .where(
                (record) => DateTime.parse(
                  record['last_interaction'] as String,
                ).isAfter(thirtyDaysAgo),
              )
              .map((record) => record['student_id'] as String)
              .toList(),
        );
  }
}
