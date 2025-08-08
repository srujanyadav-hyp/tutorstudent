import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  // Profile Operations
  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = client.auth.currentUser;
    if (user == null) return null;

    try {
      final response = await client.from('user_profiles').select('''
            *,
            students!inner(*),
            class_sessions!tutor_id(*),
            assignments!tutor_id(*),
            billing!parent_id(*)
          ''').eq('id', user.id).single();
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String role,
    required String fullName,
    String? phone,
    String? profileImage,
  }) async {
    try {
      // First create the auth user with data
      final userAttributes = {
        'full_name': fullName,
        'role': role,
        'phone': phone,
      };

      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: userAttributes,
      );

      if (response.user != null) {
        try {
          // Create user profile using the service role client (bypasses RLS)
          await client.rpc('create_user_profile', params: {
            'user_id': response.user!.id,
            'user_role': role,
            'user_full_name': fullName,
            'user_email': email,
          });
        } catch (e) {
          // If profile creation fails, just throw the error
          throw 'Failed to create user profile: ${e.toString()}';
        }
      }

      return response;
    } catch (e) {
      if (e is AuthException) {
        throw e.message;
      }
      throw 'Signup failed: ${e.toString()}';
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Student Operations
  Future<Map<String, dynamic>> createStudentProfile({
    required String studentId,
    String? tutorId,
    String? parentId,
    String? grade,
    String? classCode,
  }) async {
    try {
      // First check if a student profile already exists
      final existing = await client
          .from('students')
          .select()
          .eq('user_id', studentId)
          .maybeSingle();

      if (existing != null) {
        return existing;
      }

      // Create new student profile with a new UUID
      final response = await client
          .from('students')
          .insert({
            'user_id': studentId, // Use user_id instead of id
            'tutor_id': tutorId,
            'parent_id': parentId,
            'grade': grade,
            'class_code': classCode,
          })
          .select()
          .single();

      return response;
    } catch (e) {
      throw 'Failed to create student profile: ${e.toString()}';
    }
  }

  // Class Session Operations
  Future<Map<String, dynamic>> createClassSession({
    required String tutorId,
    required String title,
    String? description,
    required DateTime scheduledAt,
    String? videoLink,
  }) async {
    try {
      final response = await client
          .from('class_sessions')
          .insert({
            'tutor_id': tutorId,
            'title': title,
            'description': description,
            'scheduled_at': scheduledAt.toIso8601String(),
            'video_link': videoLink,
          })
          .select()
          .single();

      return response;
    } catch (e) {
      throw 'Failed to create class session: ${e.toString()}';
    }
  }

  // Assignment Operations
  Future<Map<String, dynamic>> createAssignment({
    required String tutorId,
    required String title,
    String? description,
    DateTime? dueDate,
  }) async {
    try {
      final response = await client
          .from('assignments')
          .insert({
            'tutor_id': tutorId,
            'title': title,
            'description': description,
            'due_date': dueDate?.toIso8601String(),
          })
          .select()
          .single();

      return response;
    } catch (e) {
      throw 'Failed to create assignment: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> submitAssignment({
    required String assignmentId,
    required String studentId,
    required String submittedFile,
    String? feedback,
  }) async {
    try {
      final response = await client
          .from('assignment_submissions')
          .insert({
            'assignment_id': assignmentId,
            'student_id': studentId,
            'submitted_file': submittedFile,
            'feedback': feedback,
          })
          .select()
          .single();

      return response;
    } catch (e) {
      throw 'Failed to submit assignment: ${e.toString()}';
    }
  }

  Future<List<Map<String, dynamic>>> getAssignments(String tutorId) async {
    try {
      final response = await client.from('assignments').select('''
            *,
            assignment_submissions (
              *,
              student:user_profiles!inner(*)
            )
          ''').eq('tutor_id', tutorId).order('due_date');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw 'Failed to get assignments: ${e.toString()}';
    }
  }
}
