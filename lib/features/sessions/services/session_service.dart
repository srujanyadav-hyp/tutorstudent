import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tutor_session.dart';

class SessionService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<TutorSession>> getTutorSessions(String tutorId) async {
    try {
      final response = await _client
          .from('class_sessions')
          .select('*, student_sessions(student_id)')
          .eq('tutor_id', tutorId)
          .order('scheduled_at');

      return response.map<TutorSession>((json) {
        // Extract student IDs from the joined table
        final studentSessions = json['student_sessions'] as List?;
        final studentIds = studentSessions
            ?.map((session) => session['student_id'] as String)
            .toList();

        // Remove the joined data before creating the TutorSession
        json.remove('student_sessions');

        return TutorSession.fromJson({
          ...json,
          'student_ids': studentIds,
        });
      }).toList();
    } catch (e) {
      throw 'Failed to get tutor sessions: ${e.toString()}';
    }
  }

  Future<TutorSession> createSession({
    required String tutorId,
    required String title,
    String? description,
    required DateTime scheduledAt,
    String? videoLink,
    List<String>? studentIds,
  }) async {
    try {
      // First create the class session
      final sessionResponse = await _client
          .from('class_sessions')
          .insert({
            'tutor_id': tutorId,
            'title': title,
            'description': description,
            'scheduled_at': scheduledAt.toIso8601String(),
            'video_link': videoLink,
            'status': 'scheduled',
          })
          .select()
          .single();

      final session = TutorSession.fromJson(sessionResponse);

      // If student IDs are provided, create student session links
      if (studentIds != null && studentIds.isNotEmpty) {
        await _client.from('student_sessions').insert(
              studentIds
                  .map((studentId) => {
                        'session_id': session.id,
                        'student_id': studentId,
                      })
                  .toList(),
            );
      }

      return session;
    } catch (e) {
      throw 'Failed to create session: ${e.toString()}';
    }
  }

  Future<void> updateSession(TutorSession session) async {
    try {
      await _client.from('class_sessions').update({
        'title': session.title,
        'description': session.description,
        'scheduled_at': session.scheduledAt.toIso8601String(),
        'video_link': session.videoLink,
        'status': session.status,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', session.id);

      // Update student sessions if studentIds has changed
      if (session.studentIds != null) {
        // First delete all existing student sessions
        await _client
            .from('student_sessions')
            .delete()
            .eq('session_id', session.id);

        // Then insert new ones
        await _client.from('student_sessions').insert(
              session.studentIds!
                  .map((studentId) => {
                        'session_id': session.id,
                        'student_id': studentId,
                      })
                  .toList(),
            );
      }
    } catch (e) {
      throw 'Failed to update session: ${e.toString()}';
    }
  }

  Future<void> deleteSession(String sessionId) async {
    try {
      // Delete student sessions first (due to foreign key constraints)
      await _client
          .from('student_sessions')
          .delete()
          .eq('session_id', sessionId);

      // Then delete the session
      await _client.from('class_sessions').delete().eq('id', sessionId);
    } catch (e) {
      throw 'Failed to delete session: ${e.toString()}';
    }
  }

  Future<void> updateSessionStatus(String sessionId, String status) async {
    try {
      await _client.from('class_sessions').update({
        'status': status,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', sessionId);
    } catch (e) {
      throw 'Failed to update session status: ${e.toString()}';
    }
  }

  Stream<List<TutorSession>> streamTutorSessions(String tutorId) {
    return _client
        .from('class_sessions')
        .stream(primaryKey: ['id'])
        .eq('tutor_id', tutorId)
        .order('scheduled_at')
        .map((events) => events.map(TutorSession.fromJson).toList());
  }
}
