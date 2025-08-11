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
          .from('students')
          .select('''
          id,
          grade,
          created_at,
          user_profiles!inner(
            id,
            full_name,
            profile_image
          )
        ''')
          .eq('parent_id', user.id);

      return (response as List).map((student) {
        final userProfile = student['user_profiles'] as Map<String, dynamic>;
        return {
          'id': student['id'],
          'student': {
            'id': userProfile['id'],
            'full_name': userProfile['full_name'],
            'grade': student['grade'],
            'profile_image': userProfile['profile_image'],
            'created_at': student['created_at'],
          },
        };
      }).toList();
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
          .from('students')
          .select('id')
          .eq('id', studentId)
          .eq('parent_id', user.id)
          .maybeSingle();

      if (existingLink != null) {
        throw DuplicateLinkError('Student is already linked to this parent');
      }

      // Create the link by updating the student's parent_id
      final response = await supabase
          .from('students')
          .update({'parent_id': user.id})
          .eq('id', studentId)
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
          .from('students')
          .update({'parent_id': null})
          .eq('id', studentId)
          .eq('parent_id', user.id)
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
