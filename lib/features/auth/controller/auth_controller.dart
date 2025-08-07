import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/user_role.dart';
import '../../../providers/role_provider.dart';
import '../../../core/providers/supabase_provider.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/utils/error_handler.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  final supabaseService = ref.watch(supabaseServiceProvider);
  return AuthController(ref, supabaseService);
});

class AuthController extends StateNotifier<bool> {
  final Ref _ref;
  final SupabaseService _supabaseService;

  AuthController(this._ref, this._supabaseService) : super(false);

  Future<void> signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
    String? phone,
    String? profileImage,
  }) async {
    state = true;
    try {
      // Validate input
      if (fullName.trim().isEmpty) throw 'Full name is required';
      if (email.trim().isEmpty) throw 'Email is required';
      if (password.length < 6) throw 'Password must be at least 6 characters';

      final response = await _supabaseService.signUp(
        email: email,
        password: password,
        fullName: fullName,
        role: role.toString().split('.').last,
        phone: phone,
        profileImage: profileImage,
      );

      if (response.user == null) {
        throw 'Signup failed: No user data returned';
      }

      // Create role-specific profile
      final userId = response.user!.id;
      switch (role) {
        case UserRole.tutor:
          await _supabaseService.createTutorProfile(userId: userId);
          break;
        case UserRole.student:
          // For students, we'll need to assign a tutor later
          break;
        case UserRole.parent:
          // For parents, we'll need to link with students later
          break;
      }

      _showMessage(context, 'Signup successful! Please log in.');
      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      _showMessage(context, ErrorHandler.getMessage(e));
    } finally {
      state = false;
    }
  }

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    try {
      final response = await _supabaseService.signIn(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw 'Login failed';
      }

      // Get user role from database
      final userRole = await _getUserRole(response.user!.id);
      await _ref.read(userRoleProvider.notifier).setRole(userRole);

      if (context.mounted) {
        // Navigate based on role
        switch (userRole) {
          case UserRole.tutor:
            context.go('/tutor');
            break;
          case UserRole.student:
            context.go('/student');
            break;
          case UserRole.parent:
            context.go('/parent');
            break;
        }
      }
    } catch (e) {
      _showMessage(context, ErrorHandler.getMessage(e));
    } finally {
      state = false;
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    state = true;
    try {
      await _supabaseService.client.auth.resetPasswordForEmail(email);
      if (context.mounted) {
        _showMessage(context, 'Password reset email sent! Check your inbox.');
        context.go('/login');
      }
    } catch (e) {
      _showMessage(context, ErrorHandler.getMessage(e));
    } finally {
      state = false;
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    state = true;
    try {
      await _supabaseService.signOut();
      await _ref.read(userRoleProvider.notifier).clearRole();
      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      _showMessage(context, ErrorHandler.getMessage(e));
    } finally {
      state = false;
    }
  }

  Future<UserRole> _getUserRole(String userId) async {
    try {
      final response = await _supabaseService.client
          .from('users')
          .select('role')
          .eq('id', userId)
          .single();

      switch (response['role']) {
        case 'student':
          return UserRole.student;
        case 'tutor':
          return UserRole.tutor;
        case 'parent':
          return UserRole.parent;
        default:
          return UserRole.student;
      }
    } catch (e) {
      return UserRole.student;
    }
  }

  void _showMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
