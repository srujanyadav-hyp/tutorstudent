import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorconnect/core/services/supabase_service.dart';

final studentsServiceProvider = Provider((ref) => StudentsService(ref));

class StudentsService {
  final Ref _ref;

  StudentsService(this._ref);

  Future<List<Map<String, dynamic>>> getLinkedStudents() async {
    final supabase = _ref.read(supabaseServiceProvider);
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

    return response;
  }

  Future<void> linkStudent(String studentId) async {
    final supabase = _ref.read(supabaseServiceProvider);
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase.from('parent_students').insert({
      'parent_id': user.id,
      'student_id': studentId,
    });
  }

  Future<void> unlinkStudent(String studentId) async {
    final supabase = _ref.read(supabaseServiceProvider);
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await supabase
        .from('parent_students')
        .delete()
        .eq('parent_id', user.id)
        .eq('student_id', studentId);
  }
}
