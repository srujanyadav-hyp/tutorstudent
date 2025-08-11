import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentNotFoundError implements Exception {
  final String message;
  StudentNotFoundError(this.message);
}

class DuplicateLinkError implements Exception {
  final String message;
  DuplicateLinkError(this.message);
}

final studentsServiceProvider = Provider((ref) => const StudentsService());

class StudentsService {
  const StudentsService();

  Future<List<Map<String, dynamic>>> getLinkedStudents() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('Not authenticated');

      final response = await supabase
          .from('parent_students')
          .select('''
          id,
          student:student_id (
            id,
            user_id,
            full_name,
            grade,
            profile_image,
            created_at
          )
        ''')
          .eq('parent_id', user.id);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Failed to fetch linked students: ${e.toString()}');
    }
  }

  Future<String> linkStudent(String studentId) async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('Not authenticated');

      // Check if student exists
      final studentExists = await supabase
          .from('user_profiles')
          .select('id')
          .eq('id', studentId)
          .eq('role', 'student')
          .maybeSingle();

      if (studentExists == null) {
        throw StudentNotFoundError('Student not found');
      }

      // Check for existing link
      final existingLink = await supabase
          .from('parent_students')
          .select('id')
          .eq('parent_id', user.id)
          .eq('student_id', studentId)
          .maybeSingle();

      if (existingLink != null) {
        throw DuplicateLinkError('Student is already linked to this parent');
      }

      // Create the link
      final response = await supabase
          .from('parent_students')
          .insert({'parent_id': user.id, 'student_id': studentId})
          .select('id')
          .single();

      return response['id'] as String;
    } catch (e) {
      if (e is StudentNotFoundError || e is DuplicateLinkError) {
        rethrow;
      }
      throw Exception('Failed to link student: ${e.toString()}');
    }
  }

  Future<void> unlinkStudent(String studentId) async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('Not authenticated');

      final result = await supabase
          .from('parent_students')
          .delete()
          .eq('parent_id', user.id)
          .eq('student_id', studentId)
          .select('id')
          .maybeSingle();

      if (result == null) {
        throw Exception('Student was not linked to this parent');
      }
    } catch (e) {
      throw Exception('Failed to unlink student: ${e.toString()}');
    }
  }
}
