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
            *,
            user:user_profiles!student_id(*),
            sessions!inner(
              id,
              created_at,
              status
            ),
            assignments!inner(
              id,
              title,
              due_date,
              status,
              score
            )
          ''')
          .eq('tutor_id', tutorId);

      return (response as List).map((data) {
        final user = data['user'] as Map<String, dynamic>;
        final sessions = data['sessions'] as List;
        final assignments = data['assignments'] as List;

        final completedSessions = sessions
            .where((s) => s['status'] == 'completed')
            .length;
        final upcomingSessions = sessions
            .where((s) => s['status'] == 'scheduled')
            .length;

        // Calculate average performance from assignments
        double avgPerformance = 0;
        if (assignments.isNotEmpty) {
          final totalScore = assignments.fold<double>(
            0,
            (sum, assignment) =>
                sum + (assignment['score'] as num? ?? 0).toDouble(),
          );
          avgPerformance = totalScore / assignments.length;
        }

        // Get the last session date
        DateTime? lastSessionDate;
        if (sessions.isNotEmpty) {
          lastSessionDate = sessions
              .map((s) => DateTime.parse(s['created_at']))
              .reduce((a, b) => a.isAfter(b) ? a : b);
        }

        return ManagedStudent(
          id: data['id'],
          userId: user['id'],
          name: user['full_name'],
          email: user['email'],
          grade: data['grade'],
          subjects: data['subjects'],
          isActive: data['status'] == 'active',
          lastSessionDate: lastSessionDate,
          completedSessions: completedSessions,
          upcomingSessions: upcomingSessions,
          averagePerformance: avgPerformance,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get students: ${e.toString()}');
    }
  }

  Future<StudentProgress> getStudentProgress(String studentId) async {
    try {
      // Get attendance records
      final attendanceResponse = await _supabase
          .from('session_attendance')
          .select()
          .eq('student_id', studentId);

      final attendance = (attendanceResponse as List)
          .map(
            (data) => SessionAttendance(
              sessionId: data['session_id'],
              date: DateTime.parse(data['date']),
              attended: data['attended'],
              notes: data['notes'],
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
          submitted: data['submitted'],
          score: (data['score'] as num?)?.toDouble(),
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
              data['subject']: (data['progress'] as num).toDouble(),
            },
          );

      return StudentProgress(
        studentId: studentId,
        attendance: attendance,
        assignments: assignments,
        subjectProgress: subjectProgress,
      );
    } catch (e) {
      throw Exception('Failed to get student progress: ${e.toString()}');
    }
  }

  Future<void> addStudent(String tutorId, String studentEmail) async {
    try {
      // First, check if the user exists
      final userResponse = await _supabase
          .from('user_profiles')
          .select()
          .eq('email', studentEmail)
          .single();

      // Create connection
      await _supabase.from('student_tutor_connections').insert({
        'tutor_id': tutorId,
        'student_id': userResponse['id'],
        'status': 'active',
      });
    } catch (e) {
      throw Exception('Failed to add student: ${e.toString()}');
    }
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
}
