import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/assignment.dart';
import '../../models/assignment_submission.dart';
import 'base_service.dart';

class AssignmentService extends BaseService {
  AssignmentService(SupabaseClient client) : super(client, 'assignments');

  Future<List<Assignment>> getTutorAssignments(String tutorId) async {
    final response =
        await table.select().eq('tutor_id', tutorId).order('due_date');
    return response.map((json) => Assignment.fromJson(json)).toList();
  }

  Future<List<Assignment>> getStudentAssignments(String studentId) async {
    final response = await client
        .from('assignments')
        .select('*, assignment_submissions!inner(*)')
        .eq('assignment_submissions.student_id', studentId)
        .order('due_date');
    return response.map((json) => Assignment.fromJson(json)).toList();
  }

  Future<AssignmentSubmission> submitAssignment({
    required String assignmentId,
    required String studentId,
    required String fileUrl,
  }) async {
    final response = await client
        .from('assignment_submissions')
        .insert({
          'assignment_id': assignmentId,
          'student_id': studentId,
          'file_url': fileUrl,
        })
        .select()
        .single();
    return AssignmentSubmission.fromJson(response);
  }

  Future<void> gradeSubmission({
    required String submissionId,
    required String grade,
    String? feedback,
  }) async {
    await client.from('assignment_submissions').update({
      'grade': grade,
      if (feedback != null) 'feedback': feedback,
    }).eq('id', submissionId);
  }

  Future<List<AssignmentSubmission>> getSubmissions(String assignmentId) async {
    final response = await client
        .from('assignment_submissions')
        .select()
        .eq('assignment_id', assignmentId);
    return response.map((json) => AssignmentSubmission.fromJson(json)).toList();
  }
}
