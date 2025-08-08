import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';

final profileServiceProvider = Provider((ref) => ProfileService());

final profileProvider =
    StateNotifierProvider<ProfileNotifier, AsyncValue<UserProfile?>>(
  (ref) => ProfileNotifier(ref.watch(profileServiceProvider)),
);

class ProfileNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  final ProfileService _profileService;

  ProfileNotifier(this._profileService) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      state = const AsyncValue.loading();
      final profile = await _profileService.getCurrentProfile();
      state = AsyncValue.data(profile);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateProfile({
    required String fullName,
    String? phone,
    String? bio,
    Map<String, dynamic>? roleSpecificData,
  }) async {
    try {
      final currentProfile = state.value;
      if (currentProfile == null) return;

      final updatedProfile = currentProfile.copyWith(
        fullName: fullName,
        phone: phone,
        bio: bio,
        roleSpecificData: roleSpecificData,
      );

      await _profileService.updateProfile(updatedProfile);
      state = AsyncValue.data(updatedProfile);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> updateProfileImage(File imageFile) async {
    try {
      final currentProfile = state.value;
      if (currentProfile == null) return;

      final imageUrl = await _profileService.uploadProfileImage(imageFile);
      final updatedProfile = currentProfile.copyWith(profileImage: imageUrl);

      await _profileService.updateProfile(updatedProfile);
      state = AsyncValue.data(updatedProfile);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    try {
      await _profileService.updatePassword(currentPassword, newPassword);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEmail(String newEmail, String password) async {
    try {
      await _profileService.updateEmail(newEmail, password);
      await loadProfile(); // Reload profile after email update
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAccount(String password) async {
    try {
      await _profileService.deleteAccount(password);
      state = const AsyncValue.data(null);
    } catch (e) {
      rethrow;
    }
  }
}
