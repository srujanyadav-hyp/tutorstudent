import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(Supabase.instance.client);
});

class AuthService {
  final SupabaseClient _supabaseClient;

  AuthService(this._supabaseClient);

  Future<Session?> getCurrentSession() async {
    try {
      final session = _supabaseClient.auth.currentSession;
      return session;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getUserRole() async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user == null) return null;

      final response = await _supabaseClient
          .from('users')
          .select('role')
          .eq('id', user.id)
          .single();

      return response['role'] as String?;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role,
    String? phone,
    String? profileImage,
  }) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user != null) {
      await _supabaseClient.from('users').insert({
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

  Future<void> updateUserRole(String role) async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) throw Exception('No user logged in');

    await _supabaseClient.from('users').upsert({'id': user.id, 'role': role});

    // Create role-specific profile
    switch (role) {
      case 'tutor':
        await _supabaseClient.from('tutors').upsert({'user_id': user.id});
        break;
      case 'student':
        // Students will be linked to tutors later
        break;

        break;
    }
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) return null;

    try {
      final response = await _supabaseClient
          .from('users')
          .select('*, tutors(*), students(*)')
          .eq('id', user.id)
          .single();
      return response;
    } catch (e) {
      return null;
    }
  }
}
