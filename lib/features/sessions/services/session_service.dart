import 'package:supabase_flutter/supabase_flutter.dart' hide Session;
import '../models/session.dart';

class SessionError implements Exception {
  final String message;
  SessionError(this.message);
  @override
  String toString() => message;
}

class SessionService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Session>> getTutorSessions(String tutorId) async {
    try {
      final response = await _client
          .from('class_sessions')
          .select('''
            *,
            student_sessions(student_id),
            attendance:session_attendance(
              id,
              student_id,
              joined_at
            )
          ''')
          .eq('tutor_id', tutorId)
          .order('scheduled_at');

      return response.map<Session>((json) {
        // Extract student IDs from the joined table
        final studentSessions = json['student_sessions'] as List?;
        final studentIds = studentSessions
            ?.map((session) => session['student_id'] as String)
            .toList();

        // Convert attendance records
        final attendanceList = (json['attendance'] as List?)
            ?.map(
              (a) =>
                  SessionAttendance.fromJson({...a, 'session_id': json['id']}),
            )
            .toList();

        // Remove the joined data before creating the Session
        json.remove('student_sessions');
        json.remove('attendance');

        return Session.fromJson({
          ...json,
          'student_ids': studentIds,
          'attendance': attendanceList,
        });
      }).toList();
    } catch (e) {
      throw SessionError('Failed to get tutor sessions: ${e.toString()}');
    }
  }

  Future<Session> createSession({
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
            'status': SessionStatus.scheduled.name,
            'created_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      final session = Session.fromJson(sessionResponse);

      // Automatically enroll all connected students in the session
      await _client.rpc(
        'enroll_all_students_in_session',
        params: {'p_session_id': session.id, 'p_tutor_id': tutorId},
      );

      // If specific student IDs are provided, ensure they are enrolled
      if (studentIds != null && studentIds.isNotEmpty) {
        for (final studentId in studentIds) {
          await _client.rpc(
            'enroll_student_in_session',
            params: {
              'p_session_id': session.id,
              'p_student_id': studentId,
              'p_tutor_id': tutorId,
            },
          );
        }
      }

      return session;
    } catch (e) {
      throw SessionError('Failed to create session: ${e.toString()}');
    }
  }

  Future<void> updateSession(Session session) async {
    try {
      await _client
          .from('class_sessions')
          .update({
            'title': session.title,
            'description': session.description,
            'scheduled_at': session.scheduledAt.toIso8601String(),
            'video_link': session.videoLink,
            'status': session.status.name,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', session.id);

      // Update student sessions if studentIds has changed
      if (session.studentIds != null) {
        // First delete all existing student sessions
        await _client
            .from('student_sessions')
            .delete()
            .eq('session_id', session.id);

        // Then insert new ones
        await _client
            .from('student_sessions')
            .insert(
              session.studentIds!
                  .map(
                    (studentId) => {
                      'session_id': session.id,
                      'student_id': studentId,
                    },
                  )
                  .toList(),
            );
      }
    } catch (e) {
      throw SessionError('Failed to update session: ${e.toString()}');
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
      throw SessionError('Failed to delete session: ${e.toString()}');
    }
  }

  Future<void> updateSessionStatus(
    String sessionId,
    SessionStatus status,
  ) async {
    try {
      await _client
          .from('class_sessions')
          .update({
            'status': status.name,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', sessionId);
    } catch (e) {
      throw SessionError('Failed to update session status: ${e.toString()}');
    }
  }

  Stream<List<Session>> streamTutorSessions(String tutorId) {
    return _client
        .from('class_sessions')
        .stream(primaryKey: ['id'])
        .eq('tutor_id', tutorId)
        .order('scheduled_at')
        .map((events) => events.map((e) => Session.fromJson(e)).toList());
  }
}
