import 'package:supabase_flutter/supabase_flutter.dart' hide Session;
import '../../models/session.dart';
import 'base_service.dart';

class SessionService extends BaseService {
  SessionService(SupabaseClient client) : super(client, 'sessions');

  Future<List<Session>> getTutorSessions(String tutorId) async {
    final response = await table
        .select()
        .eq('tutor_id', tutorId)
        .order('scheduled_at');
    return response.map((json) => Session.fromJson(json)).toList();
  }

  Future<List<Session>> getStudentSessions(String studentId) async {
    final response = await table
        .select()
        .eq('student_id', studentId)
        .order('scheduled_at');
    return response.map((json) => Session.fromJson(json)).toList();
  }

  Future<List<Session>> getUpcomingSessions(String userId) async {
    final response = await table
        .select()
        .or('tutor_id.eq.$userId,student_id.eq.$userId')
        .eq('status', 'upcoming')
        .order('scheduled_at');
    return response.map((json) => Session.fromJson(json)).toList();
  }

  Future<void> updateSessionStatus(
    String sessionId,
    SessionStatus status,
  ) async {
    await table
        .update({'status': status.toString().split('.').last})
        .eq('id', sessionId);
  }

  Future<Session> scheduleSession({
    required String tutorId,
    required String studentId,
    required String title,
    required DateTime scheduledAt,
    required int duration,
    String? meetingLink,
  }) async {
    final response = await table
        .insert({
          'tutor_id': tutorId,
          'student_id': studentId,
          'title': title,
          'scheduled_at': scheduledAt.toIso8601String(),
          'duration': duration,
          'meeting_link': meetingLink,
          'status': SessionStatus.upcoming.toString().split('.').last,
        })
        .select()
        .single();
    return Session.fromJson(response);
  }
}
