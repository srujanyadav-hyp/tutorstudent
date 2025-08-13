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
    String? phone,
    String? profileImage,
  }) async {
    state = true;
    try {
      // Validate input
      if (fullName.trim().isEmpty) throw 'Full name is required';
      if (email.trim().isEmpty) throw 'Email is required';
      if (password.length < 6) throw 'Password must be at least 6 characters';

      // Get the selected role from role provider
      final selectedRole = _ref.read(userRoleProvider);
      if (selectedRole == null) {
        throw 'Please select a role first';
      }

      final response = await _supabaseService.signUp(
        email: email,
        password: password,
        fullName: fullName,
        role: selectedRole.toString().split('.').last,
        phone: phone,
        profileImage: profileImage,
      );

      if (response.user == null) {
        throw 'Signup failed: No user data returned';
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
          default:
            context.go('/student');
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
          .from('user_profiles')
          .select('role')
          .eq('id', userId)
          .single();

      return switch (response['role']) {
        'student' => UserRole.student,
        'tutor' => UserRole.tutor,

        _ => throw 'Invalid user role',
      };
    } catch (e) {
      throw 'Failed to get user role: ${e.toString()}';
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
