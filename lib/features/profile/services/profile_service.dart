import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';

class ProfileService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<UserProfile> getCurrentProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    final response =
        await _client.from('user_profiles').select().eq('id', user.id).single();

    // Ensure nullable fields are handled properly
    return UserProfile.fromJson({
      ...response,
      'phone': response['phone'] ?? '',
      'bio': response['bio'] ?? '',
      'profile_image': response['profile_image'],
      'role_specific_data': response['role_specific_data'] ?? {},
    });
  }

  Future<String> uploadProfileImage(File imageFile) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    final fileExt = imageFile.path.split('.').last;
    final fileName =
        '${user.id}_${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final filePath = 'profile_images/$fileName';

    await _client.storage.from('public').upload(filePath, imageFile);

    final imageUrl = _client.storage.from('public').getPublicUrl(filePath);
    return imageUrl;
  }

  Future<void> updateProfile(UserProfile profile) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await _client.from('user_profiles').upsert({
      'id': profile.id,
      'full_name': profile.fullName,
      'phone': profile.phone,
      'bio': profile.bio,
      'profile_image': profile.profileImage,
      'role_specific_data': profile.roleSpecificData,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // First verify current password by trying to sign in
    await _client.auth.signInWithPassword(
      email: user.email!,
      password: currentPassword,
    );

    // If sign in successful, update password
    await _client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  Future<void> updateEmail(String newEmail, String password) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // First verify password by trying to sign in
    await _client.auth.signInWithPassword(
      email: user.email!,
      password: password,
    );

    // If sign in successful, update email
    await _client.auth.updateUser(
      UserAttributes(email: newEmail),
    );
  }

  Future<void> deleteAccount(String password) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // First verify password by trying to sign in
    await _client.auth.signInWithPassword(
      email: user.email!,
      password: password,
    );

    // Delete profile data first
    await _client.from('user_profiles').delete().eq('id', user.id);

    // Then delete the auth user
    await _client.auth.admin.deleteUser(user.id);
  }
}
