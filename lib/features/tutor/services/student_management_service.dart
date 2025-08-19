import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/student_management.dart';

final studentManagementServiceProvider = Provider(
  (ref) => StudentManagementService(),
);

class StudentManagementService {
  final _supabase = Supabase.instance.client;

  Future<List<ManagedStudent>> getStudents(String tutorId) async {
    try {
      final response = await _supabase
          .from('student_tutor_connections')
          .select('''
            id,
            student_id,
            grade,
            subjects,
            status,
            user:user_profiles!student_id(
              id,
              full_name,
              email
            )
          ''')
          .eq('tutor_id', tutorId);

      return (response as List).map((data) {
        final user = data['user'] as Map<String, dynamic>;

        return ManagedStudent(
          id: data['id'],
          userId: user['id'],
          name: user['full_name'],
          email: user['email'],
          grade: data['grade'],
          subjects: data['subjects'],
          isActive: data['status'] == 'active',
          lastSessionDate: null,
          completedSessions: 0,
          upcomingSessions: 0,
          averagePerformance: 0,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get students: ${e.toString()}');
    }
  }

  Future<StudentProgress> getStudentProgress(String studentId) async {
    try {
      // Get attendance records for student's classes
      final attendanceResponse = await _supabase
          .from('student_class_attendance')
          .select('''
            *,
            session:class_sessions(
              id,
              scheduled_at
            )
          ''')
          .eq('student_id', studentId);

      final attendance = (attendanceResponse as List)
          .map(
            (data) => SessionAttendance(
              sessionId: data['session_id'],
              date: DateTime.parse(data['session']['scheduled_at']),
              attended: true, // If there's a record, they attended
              notes: null, // Notes are not currently stored
            ),
          )
          .toList();

      // Get assignment progress
      final assignmentResponse = await _supabase
          .from('assignment_submissions')
          .select('''
            *,
            assignment:assignments(
              id,
              title,
              due_date
            )
          ''')
          .eq('student_id', studentId);

      final assignments = (assignmentResponse as List).map((data) {
        final assignment = data['assignment'] as Map<String, dynamic>;
        return AssignmentProgress(
          assignmentId: assignment['id'],
          title: assignment['title'],
          dueDate: DateTime.parse(assignment['due_date']),
          completed: data['submitted'] as bool? ?? false,
          score: (data['score'] as num?)?.toDouble() ?? 0.0,
          feedback: data['feedback'],
        );
      }).toList();

      // Get subject progress
      final subjectResponse = await _supabase
          .from('subject_progress')
          .select()
          .eq('student_id', studentId);

      final subjectProgress = (subjectResponse as List)
          .fold<Map<String, double>>(
            {},
            (map, data) => {
              ...map,
              data['subject']: (data['progress'] as num?)?.toDouble() ?? 0.0,
            },
          );

      return StudentProgress(
        studentId: studentId,
        sessionHistory: attendance,
        assignments: assignments,
        subjectPerformance: subjectProgress,
      );
    } catch (e) {
      throw Exception('Failed to get student progress: ${e.toString()}');
    }
  }

  Future<void> addStudent(String tutorId, String studentEmail) async {
    // Disabled by product decision: students initiate connection after payment
    throw Exception(
      'Adding students manually is disabled. Students must connect after payment.',
    );
  }

  Future<void> removeStudent(String connectionId) async {
    try {
      await _supabase
          .from('student_tutor_connections')
          .update({'status': 'inactive'})
          .eq('id', connectionId);
    } catch (e) {
      throw Exception('Failed to remove student: ${e.toString()}');
    }
  }

  Future<void> updateStudentDetails(
    String connectionId, {
    String? grade,
    String? subjects,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (grade != null) updates['grade'] = grade;
      if (subjects != null) updates['subjects'] = subjects;

      if (updates.isNotEmpty) {
        await _supabase
            .from('student_tutor_connections')
            .update(updates)
            .eq('id', connectionId);
      }
    } catch (e) {
      throw Exception('Failed to update student details: ${e.toString()}');
    }
  }

  Future<void> updateSubjectProgress(
    String studentId,
    String subject,
    double progress,
  ) async {
    try {
      await _supabase.from('subject_progress').upsert({
        'student_id': studentId,
        'subject': subject,
        'progress': progress,
        'last_updated': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to update subject progress: ${e.toString()}');
    }
  }
}
