import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/user_role.dart';
import '../../providers/role_provider.dart';
import 'onboarding_screen.dart';
import 'role_selection_screen.dart';

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
    final userRole = ref.read(userRoleProvider);

    if (userRole == null) {
      context.go('/onboarding');
    } else {
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
