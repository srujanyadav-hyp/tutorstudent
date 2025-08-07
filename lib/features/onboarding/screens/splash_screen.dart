import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    final currentUser = supabase.auth.currentUser;

    if (currentUser == null) {
      // New user flow: starts with onboarding
      if (context.mounted) {
        context.go('/onboarding');
      }
      return;
    }

    // For existing users, fetch their role from the database
    try {
      final userData = await supabase
          .from('users')
          .select('role')
          .eq('id', currentUser.id)
          .maybeSingle();

      if (context.mounted) {
        if (userData?['role'] != null) {
          String roleStr = userData!['role'] as String;
          // Navigate to role-specific dashboard
          switch (roleStr) {
            case 'tutor':
              context.go('/tutor');
              break;
            case 'student':
              context.go('/student');
              break;
            case 'parent':
              context.go('/parent');
              break;
            default:
              context.go('/onboarding');
          }
        } else {
          // If no role found, send to onboarding
          context.go('/onboarding');
        }
      }
    } catch (e) {
      // If error occurs, send to onboarding
      if (context.mounted) {
        context.go('/onboarding');
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
