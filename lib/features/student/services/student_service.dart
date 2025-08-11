import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/student_dashboard_stats.dart';
import '../models/student_profile.dart';
import '../../messaging/models/chat_message.dart';

final studentServiceProvider = Provider((ref) => StudentService());

class StudentService {
  final _supabase = Supabase.instance.client;

  Future<StudentProfile> getStudentProfile(String studentId) async {
    try {
      final profile = await _supabase
          .from('user_profiles')
          .select('id, full_name, email, created_at')
          .eq('id', studentId)
          .single();

      final studentData = await _supabase
          .from('students')
          .select('parent_id, grade, subjects')
          .eq('id', studentId)
          .maybeSingle();

      final connections = await _supabase
          .from('student_tutor_connections')
          .select('tutor_id, subjects')
          .eq('student_id', studentId);

      final List<String> subjectsFromStudent =
          (studentData != null && studentData['subjects'] is List)
          ? (studentData['subjects'] as List).map((e) => e.toString()).toList()
          : const <String>[];

      final List<String> subjectsFromConnections = (connections as List)
          .map(
            (conn) =>
                (conn['subjects'] as String?)?.split(',') ?? const <String>[],
          )
          .expand((e) => e)
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toSet()
          .toList();

      return StudentProfile(
        id: profile['id'] as String,
        name: profile['full_name'] as String,
        email: profile['email'] as String,
        grade: (studentData != null ? studentData['grade'] as String? : null),
        subjects:
            (subjectsFromStudent.isNotEmpty
                    ? subjectsFromStudent
                    : subjectsFromConnections)
                .toList(),
        parentId: (studentData != null
            ? studentData['parent_id'] as String?
            : null),
        tutorIds: (connections as List)
            .map((conn) => conn['tutor_id'] as String)
            .toList(),
        subjectProgress: const <String, double>{},
        createdAt: DateTime.parse(profile['created_at'] as String),
      );
    } catch (e) {
      throw 'Failed to get student profile: ${e.toString()}';
    }
  }

  Future<StudentDashboardStats> getStudentStats(String studentId) async {
    try {
      final now = DateTime.now();

      // Sessions joined by this student
      final sessionsResponse = await _supabase
          .from('class_sessions')
          .select('''
            *,
            student_class_attendance!inner(student_id)
          ''')
          .eq('student_class_attendance.student_id', studentId);

      final sessions = List<Map<String, dynamic>>.from(
        sessionsResponse as List,
      );
      final totalSessions = sessions.length;
      final upcomingSessions = sessions
          .where((s) => DateTime.parse(s['scheduled_at']).isAfter(now))
          .length;

      // Assignment submissions by this student
      final assignmentsResponse = await _supabase
          .from('assignment_submissions')
          .select(''',*, assignments(*)''')
          .eq('student_id', studentId);

      final assignments = List<Map<String, dynamic>>.from(
        assignmentsResponse as List,
      );
      final completedAssignments = assignments
          .where((a) => a['submitted_at'] != null)
          .length;
      final pendingAssignments = assignments
          .where((a) => a['submitted_at'] == null)
          .length;

      // Average score not available in current schema; default to 0
      final double averageScore = 0;

      // Subject performance not available in current schema; use empty map
      final Map<String, double> subjectPerformance = const {};

      // Session dates for charts
      final sessionDates =
          sessions
              .map((s) => DateTime.parse(s['scheduled_at'] as String))
              .toList()
            ..sort();

      // Simple progress trend placeholder based on submissions per day
      final progressTrend = List<double>.generate(7, (index) {
        final day = now.subtract(Duration(days: 6 - index));
        final count = assignments.where((a) => a['submitted_at'] != null).where(
          (a) {
            final submissionDate = DateTime.parse(a['submitted_at'] as String);
            return submissionDate.year == day.year &&
                submissionDate.month == day.month &&
                submissionDate.day == day.day;
          },
        ).length;
        return count.toDouble();
      });

      return StudentDashboardStats(
        totalSessions: totalSessions,
        upcomingSessions: upcomingSessions,
        completedAssignments: completedAssignments,
        pendingAssignments: pendingAssignments,
        averageScore: averageScore,
        subjectPerformance: subjectPerformance,
        sessionDates: sessionDates,
        progressTrend: progressTrend,
      );
    } catch (e) {
      throw 'Failed to get student stats: ${e.toString()}';
    }
  }

  Future<List<Map<String, dynamic>>> getAvailableTutors() async {
    try {
      final response = await _supabase
          .from('user_profiles')
          .select('''
            id,
            full_name,
            email,
            bio,
            profile_image,
            role_specific_data,
            tutor_reviews:tutor_reviews!tutor_reviews_tutor_id_fkey(rating)
          ''')
          .eq('role', 'tutor');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw 'Failed to get available tutors: ${e.toString()}';
    }
  }

  Future<void> connectWithTutor(String studentId, String tutorId) async {
    try {
      await _supabase.from('student_tutor_connections').insert({
        'student_id': studentId,
        'tutor_id': tutorId,
        'status': 'active',
      });
    } catch (e) {
      throw 'Failed to connect with tutor: ${e.toString()}';
    }
  }

  Stream<List<Map<String, dynamic>>> streamUpcomingSessions(String studentId) {
    // Streaming with joins is not supported; fall back to periodic polling
    return Stream<void>.periodic(
      const Duration(seconds: 10),
    ).asyncMap((_) => _fetchUpcomingSessions(studentId));
  }

  Future<List<Map<String, dynamic>>> _fetchUpcomingSessions(
    String studentId,
  ) async {
    final nowIso = DateTime.now().toIso8601String();
    final response = await _supabase
        .from('class_sessions')
        .select('''
          *,
          student_class_attendance!inner(student_id)
        ''')
        .gt('scheduled_at', nowIso)
        .eq('student_class_attendance.student_id', studentId)
        .order('scheduled_at');
    return List<Map<String, dynamic>>.from(response as List);
  }

  Stream<List<Map<String, dynamic>>> streamAssignments(String studentId) {
    // Streaming with joins is not supported; fall back to periodic polling
    return Stream<void>.periodic(
      const Duration(seconds: 10),
    ).asyncMap((_) => _fetchAssignments(studentId));
  }

  Future<List<Map<String, dynamic>>> _fetchAssignments(String studentId) async {
    final response = await _supabase
        .from('assignments')
        .select('''
          *,
          assignment_submissions!left(
            id, submitted_file, submitted_at, feedback, student_id
          )
        ''')
        .order('due_date');

    final List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(
      response as List,
    );

    // Keep only assignments (or enrich) relevant to this student
    return items.map((a) {
      final subs = (a['assignment_submissions'] as List?) ?? const [];
      final subForStudent = subs.cast<Map<String, dynamic>?>().firstWhere(
        (s) => s != null && s['student_id'] == studentId,
        orElse: () => null,
      );

      return {
        ...a,
        // Flatten commonly used submission fields for the active student
        'submitted_at': subForStudent?['submitted_at'],
        'grade': subForStudent?['feedback'] ?? subForStudent?['grade'],
      };
    }).toList();
  }

  Future<Map<String, dynamic>> getSessionDetails(String sessionId) async {
    try {
      final response = await _supabase
          .from('class_sessions')
          .select('''
            *,
            tutor:tutor_id(
              id,
              full_name,
              email,
              profile_image
            )
          ''')
          .eq('id', sessionId)
          .single();

      final tutor = response['tutor'] as Map<String, dynamic>;
      return {
        ...response,
        'tutor_name': tutor['full_name'],
        'tutor_email': tutor['email'],
        'tutor_profile_image': tutor['profile_image'],
        // Feedback/materials not in current schema
        'feedback_enabled': false,
        'session_feedback': null,
      };
    } catch (e) {
      throw 'Failed to get session details: ${e.toString()}';
    }
  }

  Future<void> submitSessionFeedback(
    String sessionId,
    String studentId,
    double rating,
    String feedback,
  ) async {
    try {
      // Fetch tutor_id for the session
      final session = await _supabase
          .from('class_sessions')
          .select('tutor_id')
          .eq('id', sessionId)
          .single();

      await _supabase.from('tutor_reviews').insert({
        'session_id': sessionId,
        'tutor_id': session['tutor_id'],
        'reviewer_id': studentId,
        'rating': rating.round(),
        'review_text': feedback,
      });
    } catch (e) {
      throw 'Failed to submit session feedback: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> getAssignmentDetails(String assignmentId) async {
    try {
      final response = await _supabase
          .from('assignments')
          .select('''
            *,
            tutor:tutor_id(
              id,
              full_name,
              email,
              profile_image
            ),
            assignment_submissions(
              id,
              submitted_file,
              submitted_at,
              feedback,
              student_id
            )
          ''')
          .eq('id', assignmentId)
          .single();

      final tutor = response['tutor'] as Map<String, dynamic>;
      final submissions = (response['assignment_submissions'] as List?) ?? [];

      return {
        ...response,
        'tutor_name': tutor['full_name'],
        'tutor_email': tutor['email'],
        'tutor_profile_image': tutor['profile_image'],
        'submission': submissions.isNotEmpty ? submissions[0] : null,
      };
    } catch (e) {
      throw 'Failed to get assignment details: ${e.toString()}';
    }
  }

  Future<void> submitAssignment(
    String assignmentId,
    String studentId,
    String comment,
    File file,
  ) async {
    try {
      // Upload the file to storage (bucket must exist)
      final fileName =
          '${studentId}_${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      final filePath = 'assignments/$assignmentId/$fileName';

      String? publicUrl;
      try {
        await _supabase.storage
            .from('student-submissions')
            .upload(filePath, file);
        publicUrl = _supabase.storage
            .from('student-submissions')
            .getPublicUrl(filePath);
      } catch (_) {
        // If storage bucket is missing, fall back to saving file name only
        publicUrl = fileName;
      }

      // Create the submission record
      await _supabase.from('assignment_submissions').insert({
        'assignment_id': assignmentId,
        'student_id': studentId,
        'submitted_file': publicUrl,
        'submitted_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw 'Failed to submit assignment: ${e.toString()}';
    }
  }

  Future<void> sendMessage(
    String studentId,
    String tutorId,
    String content, {
    String? attachmentUrl,
    String? attachmentType,
  }) async {
    try {
      await _supabase.from('chats').insert({
        'sender_id': studentId,
        'receiver_id': tutorId,
        'message': content,
        'attachment_url': attachmentUrl,
      });
    } catch (e) {
      throw 'Failed to send message: ${e.toString()}';
    }
  }

  Stream<List<ChatMessage>> streamChatMessages(
    String studentId,
    String tutorId,
  ) {
    return _supabase
        .from('chats')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true)
        .map((response) {
          return response
              .where(
                (record) =>
                    (record['sender_id'] == studentId ||
                        record['receiver_id'] == studentId) &&
                    (record['sender_id'] == tutorId ||
                        record['receiver_id'] == tutorId),
              )
              .map((json) => ChatMessage.fromJson(json))
              .toList();
        });
  }

  Future<void> markMessagesAsRead(String receiverId, String senderId) async {
    try {
      await _supabase
          .from('chats')
          .update({'is_read': true})
          .eq('receiver_id', receiverId)
          .eq('sender_id', senderId)
          .eq('is_read', false);
    } catch (e) {
      throw 'Failed to mark messages as read: ${e.toString()}';
    }
  }

  Stream<int> streamUnreadMessageCount(String studentId) {
    return _supabase
        .from('chats')
        .stream(primaryKey: ['id'])
        .map(
          (response) => response
              .where(
                (record) =>
                    record['receiver_id'] == studentId && !record['is_read'],
              )
              .length,
        );
  }
}
