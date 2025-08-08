import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/forget_password_screen.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/onboarding/screens/role_selection_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/tutor/screens/tutor_layout.dart';
import '../../features/student/screens/student_dashboard.dart';
import '../../features/parent/screens/parent_dashboard.dart';
import '../../models/user_role.dart';
import '../../providers/role_provider.dart';

String? _getRedirectLocation(
  String location,
  SupabaseClient supabase,
  UserRole? role,
  GoRouterState state,
) {
  final isAuth = supabase.auth.currentUser != null;

  // For authenticated users
  if (isAuth && role != null) {
    // Direct to dashboard if trying to access auth or onboarding screens
    if (location == '/splash' ||
        location == '/onboarding' ||
        location == '/select-role' ||
        location == '/login' ||
        location == '/signup') {
      switch (role) {
        case UserRole.tutor:
          return '/tutor';
        case UserRole.student:
          return '/student';
        case UserRole.parent:
          return '/parent';
      }
    }
    return null;
  }

  // For non-authenticated users
  if (!isAuth) {
    // Protect dashboard routes
    if (location.startsWith('/tutor') ||
        location.startsWith('/student') ||
        location.startsWith('/parent')) {
      return '/login';
    }

    // Enforce onboarding flow
    if (location == '/signup' || location == '/login') {
      if (role == null) {
        // If no role is selected, redirect to role selection
        return '/select-role';
      }
    }

    // If trying to access role selection without seeing onboarding
    if (location == '/select-role' &&
        !state.extra.toString().contains('fromOnboarding')) {
      return '/onboarding';
    }
  }

  // Let other routes pass through normally
  return null;
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final role = ref.watch(userRoleProvider);
  final supabase = Supabase.instance.client;

  return GoRouter(
    redirect: (context, state) {
      return _getRedirectLocation(state.uri.path, supabase, role, state);
    },
    initialLocation: '/splash',
    routes: [
      // Initial Routes
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
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
        builder: (context, state) => const TutorLayout(),
      ),
      GoRoute(
        path: '/student',
        builder: (context, state) => const StudentDashboard(),
      ),
      GoRoute(
        path: '/parent',
        builder: (context, state) => const ParentDashboard(),
      ),

      // Profile Route
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // Root Route
      GoRoute(path: '/', redirect: (context, state) => '/splash'),
    ],
  );
});
