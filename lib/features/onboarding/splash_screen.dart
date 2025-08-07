import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user_role.dart';
import '../../providers/role_provider.dart';
import '../../core/providers/supabase_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), checkUserRoleAndNavigate);
  }

  void checkUserRoleAndNavigate() async {
    final supabase = Supabase.instance.client;
    final userRole = ref.read(userRoleProvider);
    final isAuthenticated = supabase.auth.currentUser != null;

    if (!isAuthenticated) {
      // New user flow: splash -> onboarding
      if (context.mounted) {
        context.go('/onboarding');
      }
      return;
    }

    // Existing user: directly to dashboard based on role
    if (context.mounted) {
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
        case null:
          // If somehow no role is set, go to onboarding
          context.go('/onboarding');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'TutorConnect',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
