import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_role.dart';
import '../core/providers/supabase_provider.dart';
import 'role_provider.dart';

/// Provider for auth state changes that updates user role
final authStateChangesProvider = StreamProvider<void>((ref) {
  final supabaseService = ref.watch(supabaseServiceProvider);

  final sub = supabaseService.client.auth.onAuthStateChange.listen((
    data,
  ) async {
    final AuthChangeEvent event = data.event;
    final Session? session = data.session;

    if (event == AuthChangeEvent.signedIn && session != null) {
      try {
        // Fetch user role from Supabase
        final response = await supabaseService.client
            .from('users')
            .select('role')
            .eq('id', session.user.id)
            .single();

        final userRole = _getUserRoleFromString(response['role']);
        await ref.read(userRoleProvider.notifier).setRole(userRole);
      } catch (e) {
        // If there's an error, we'll clear the role
        await ref.read(userRoleProvider.notifier).clearRole();
      }
    } else if (event == AuthChangeEvent.signedOut || session == null) {
      await ref.read(userRoleProvider.notifier).clearRole();
    }
  });

  ref.onDispose(() {
    sub.cancel();
  });

  return const Stream.empty();
});

UserRole _getUserRoleFromString(String? value) {
  switch (value) {
    case 'tutor':
      return UserRole.tutor;
    case 'student':
      return UserRole.student;

    default:
      return UserRole.student; // Default to student as a fallback
  }
}
