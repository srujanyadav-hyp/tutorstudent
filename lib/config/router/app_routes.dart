import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/auth/forget_password_screen.dart';
import '../../features/onboarding/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/onboarding/role_selection_screen.dart';
import '../../features/tutor/tutor_dashboard.dart';
import '../../features/student/student_dashboard.dart';
import '../../features/parent/parent_dashboard.dart';
import '../../models/user_role.dart';
import '../../providers/role_provider.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final role = ref.watch(userRoleProvider);
  final supabase = Supabase.instance.client;

  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // Initial Routes
      GoRoute(
        path: '/splash',
        builder: (context, state) {
          // If user is already logged in, redirect to dashboard
          if (supabase.auth.currentUser != null) {
            switch (role) {
              case UserRole.tutor:
                return const TutorDashboard();
              case UserRole.student:
                return const StudentDashboard();
              case UserRole.parent:
                return const ParentDashboard();
              case null:
                return const OnboardingScreen();
            }
          }
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/select-role',
        builder: (context, state) => const RoleSelectionScreen(),
      ),

      // Auth Routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Dashboard Routes
      GoRoute(
        path: '/tutor',
        builder: (context, state) => const TutorDashboard(),
      ),
      GoRoute(
        path: '/student',
        builder: (context, state) => const StudentDashboard(),
      ),
      GoRoute(
        path: '/parent',
        builder: (context, state) => const ParentDashboard(),
      ),

      // Root Route with Role-based Redirection
      GoRoute(
        path: '/',
        builder: (context, state) {
          if (role == null) {
            return const LoginScreen();
          }

          switch (role) {
            case UserRole.tutor:
              return const TutorDashboard();
            case UserRole.student:
              return const StudentDashboard();
            case UserRole.parent:
              return const ParentDashboard();
          }
        },
      ),
    ],
  );
});
