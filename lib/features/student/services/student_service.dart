import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/student_dashboard_stats.dart';
import '../models/student_profile.dart';
import '../models/chat_message.dart';

final studentServiceProvider = Provider((ref) => StudentService());

class StudentService {
  final _supabase = Supabase.instance.client;

  Future<StudentProfile> getStudentProfile(String studentId) async {
    try {
      final response = await _supabase
          .from('user_profiles')
          .select('''
            *,
            student_tutor_connections!student_id(
              tutor_id,
              subjects,
              grade
            ),
            students!inner(
              parent_id,
              subject_progress
            )
          ''')
          .eq('id', studentId)
          .single();

      // Process the response to create a StudentProfile
      final tutorConnections = response['student_tutor_connections'] as List;
      final studentData = response['students'][0] as Map<String, dynamic>;

      return StudentProfile(
        id: response['id'],
        name: response['full_name'],
        email: response['email'],
        grade: tutorConnections.isNotEmpty
            ? tutorConnections[0]['grade']
            : null,
        subjects: tutorConnections
            .map((conn) => conn['subjects'] as String)
            .expand((subjects) => subjects.split(','))
            .toSet()
            .toList(),
        parentId: studentData['parent_id'],
        tutorIds: tutorConnections
            .map((conn) => conn['tutor_id'] as String)
            .toList(),
        subjectProgress: Map<String, double>.from(
          studentData['subject_progress'] ?? {},
        ),
        createdAt: DateTime.parse(response['created_at']),
      );
    } catch (e) {
      throw 'Failed to get student profile: ${e.toString()}';
    }
  }

  Future<StudentDashboardStats> getStudentStats(String studentId) async {
    try {
      final now = DateTime.now();

      // Get session data
      final sessionsResponse = await _supabase
          .from('class_sessions')
          .select('''
            *,
            student_class_attendance!inner(*)
          ''')
          .eq('student_class_attendance.student_id', studentId);

      final sessions = sessionsResponse as List;
      final totalSessions = sessions.length;
      final upcomingSessions = sessions
          .where((s) => DateTime.parse(s['scheduled_at']).isAfter(now))
          .length;

      // Get assignment data
      final assignmentsResponse = await _supabase
          .from('assignment_submissions')
          .select('''
            *,
            assignments(*)
          ''')
          .eq('student_id', studentId);

      final assignments = assignmentsResponse as List;
      final completedAssignments = assignments
          .where((a) => a['submitted_at'] != null)
          .length;
      final pendingAssignments = assignments
          .where((a) => a['submitted_at'] == null)
          .length;

      // Calculate average score
      double totalScore = 0;
      int scoredAssignments = 0;
      for (var assignment in assignments) {
        if (assignment['score'] != null) {
          totalScore += (assignment['score'] as num).toDouble();
          scoredAssignments++;
        }
      }
      final averageScore = scoredAssignments > 0
          ? totalScore / scoredAssignments
          : 0;

      // Get subject performance
      final subjectProgressResponse = await _supabase
          .from('students')
          .select('subject_progress')
          .eq('id', studentId)
          .single();

      final subjectPerformance = Map<String, double>.from(
        subjectProgressResponse['subject_progress'] ?? {},
      );

      // Get session dates for attendance tracking
      final sessionDates =
          sessions.map((s) => DateTime.parse(s['scheduled_at'])).toList()
            ..sort();

      // Calculate progress trend (last 7 days)
      final progressTrend = List.generate(7, (index) {
        final day = now.subtract(Duration(days: 6 - index));
        return assignments
                .where((a) => a['submitted_at'] != null)
                .where((a) {
                  final submissionDate = DateTime.parse(a['submitted_at']);
                  return submissionDate.year == day.year &&
                      submissionDate.month == day.month &&
                      submissionDate.day == day.day;
                })
                .fold<double>(
                  0,
                  (sum, a) => sum + ((a['score'] as num?)?.toDouble() ?? 0),
                ) /
            assignments.length;
      });

      return StudentDashboardStats(
        totalSessions: totalSessions,
        upcomingSessions: upcomingSessions,
        completedAssignments: completedAssignments,
        pendingAssignments: pendingAssignments,
        averageScore: averageScore.toDouble(),
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
            tutor_reviews(rating)
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
    return _supabase
        .from('class_sessions')
        .stream(primaryKey: ['id'])
        .eq('student_class_attendance.student_id', studentId)
        .order('scheduled_at')
        .map((response) => List<Map<String, dynamic>>.from(response));
  }

  Stream<List<Map<String, dynamic>>> streamAssignments(String studentId) {
    return _supabase
        .from('assignments')
        .stream(primaryKey: ['id'])
        .eq('assignment_submissions.student_id', studentId)
        .order('due_date')
        .map((response) => List<Map<String, dynamic>>.from(response));
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
            ),
            materials:session_materials(
              id,
              name,
              file_url,
              created_at
            ),
            session_feedback!inner(
              rating,
              feedback,
              created_at
            )
          ''')
          .eq('id', sessionId)
          .single();

      // Transform response to include tutor details at the top level
      final tutor = response['tutor'] as Map<String, dynamic>;
      return {
        ...response,
        'tutor_name': tutor['full_name'],
        'tutor_email': tutor['email'],
        'tutor_profile_image': tutor['profile_image'],
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
      await _supabase.from('session_feedback').insert({
        'session_id': sessionId,
        'student_id': studentId,
        'rating': rating,
        'feedback': feedback,
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
            materials:assignment_materials(
              id,
              name,
              file_url,
              created_at
            ),
            assignment_submissions(
              id,
              comment,
              file_url,
              submitted_at,
              score,
              feedback
            )
          ''')
          .eq('id', assignmentId)
          .single();

      // Transform response to include tutor details at the top level
      final tutor = response['tutor'] as Map<String, dynamic>;
      final submissions = response['assignment_submissions'] as List;

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
      // Upload the file to storage
      final fileName =
          '${studentId}_${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      final filePath = 'assignments/$assignmentId/$fileName';

      await _supabase.storage
          .from('student-submissions')
          .upload(filePath, file);

      // Get the public URL
      final fileUrl = _supabase.storage
          .from('student-submissions')
          .getPublicUrl(filePath);

      // Create the submission record
      await _supabase.from('assignment_submissions').insert({
        'assignment_id': assignmentId,
        'student_id': studentId,
        'comment': comment,
        'file_url': fileUrl,
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
      await _supabase.from('chat_messages').insert({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'sender_id': studentId,
        'receiver_id': tutorId,
        'content': content,
        'timestamp': DateTime.now().toIso8601String(),
        'is_read': false,
        'attachment_url': attachmentUrl,
        'attachment_type': attachmentType,
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
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .order('timestamp', ascending: true)
        .map((response) {
          return response
              .where(
                (record) =>
                    (record['sender_id'] == studentId ||
                        record['receiver_id'] == studentId) &&
                    (record['sender_id'] == tutorId ||
                        record['receiver_id'] == tutorId),
              )
              .map((json) => ChatMessage.fromJson(json as Map<String, dynamic>))
              .toList();
        });
  }

  Future<void> markMessagesAsRead(String receiverId, String senderId) async {
    try {
      await _supabase
          .from('chat_messages')
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
        .from('chat_messages')
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
