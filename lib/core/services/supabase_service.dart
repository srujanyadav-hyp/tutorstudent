import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  // User Operations
  Future<User?> getCurrentUser() async {
    return client.auth.currentUser;
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
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {
        'role': role,
        'full_name': fullName,
        'phone': phone,
        'profile_image': profileImage,
      },
    );

    if (response.user != null) {
      // Create user record in users table
      await client.from('users').insert({
        'id': response.user!.id,
        'role': role,
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'profile_image': profileImage,
      });
    }

    return response;
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

  // Tutor Operations
  Future<Map<String, dynamic>> createTutorProfile({
    required String userId,
    String? expertise,
    String? qualifications,
    int? experienceYears,
    double? pricing,
  }) async {
    try {
      final response = await client
          .from('tutors')
          .insert({
            'user_id': userId,
            'expertise': expertise,
            'qualifications': qualifications,
            'experience_years': experienceYears,
            'pricing': pricing,
          })
          .select()
          .single();

      return response;
    } catch (e) {
      throw 'Failed to create tutor profile: ${e.toString()}';
    }
  }

  // Student Operations
  Future<Map<String, dynamic>> createStudentProfile({
    required String userId,
    required String tutorId,
    String? parentId,
    String? grade,
    String? subjects,
  }) async {
    try {
      final response = await client
          .from('students')
          .insert({
            'user_id': userId,
            'tutor_id': tutorId,
            'parent_id': parentId,
            'grade': grade,
            'subjects': subjects,
          })
          .select()
          .single();

      return response;
    } catch (e) {
      throw 'Failed to create student profile: ${e.toString()}';
    }
  }

  // Session Operations
  Future<Map<String, dynamic>> createSession({
    required String tutorId,
    required String studentId,
    required String title,
    required DateTime scheduledAt,
    required int duration,
    String? meetingLink,
  }) async {
    try {
      final response = await client
          .from('sessions')
          .insert({
            'tutor_id': tutorId,
            'student_id': studentId,
            'title': title,
            'scheduled_at': scheduledAt.toIso8601String(),
            'duration': duration,
            'meeting_link': meetingLink,
            'status': 'upcoming',
          })
          .select()
          .single();

      return response;
    } catch (e) {
      throw 'Failed to create session: ${e.toString()}';
    }
  }

  Future<List<Map<String, dynamic>>> getUpcomingSessions(String userId) async {
    try {
      final response = await client
          .from('sessions')
          .select()
          .or('tutor_id.eq.$userId,student_id.eq.$userId')
          .eq('status', 'upcoming')
          .order('scheduled_at');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw 'Failed to get upcoming sessions: ${e.toString()}';
    }
  }
}
