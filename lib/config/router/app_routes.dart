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

String? _getRedirectLocation(
  String location,
  SupabaseClient supabase,
  UserRole? role,
) {
  final isAuth = supabase.auth.currentUser != null;

  // Public routes that don't require auth
  final isPublicRoute =
      location == '/splash' ||
      location == '/onboarding' ||
      location == '/select-role' ||
      location == '/signup' ||
      location == '/login' ||
      location == '/forgot-password';

  // If not authenticated and trying to access a protected route
  if (!isAuth && !isPublicRoute) {
    return '/onboarding';
  }

  // If authenticated
  if (isAuth) {
    // For authenticated users, always redirect to their dashboard
    final userRole = role;
    if (userRole != null) {
      switch (userRole) {
        case UserRole.tutor:
          return '/tutor';
        case UserRole.student:
          return '/student';
        case UserRole.parent:
          return '/parent';
      }
    }
  }

  return null;
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final role = ref.watch(userRoleProvider);
  final supabase = Supabase.instance.client;

  return GoRouter(
    redirect: (context, state) {
      return _getRedirectLocation(state.uri.path, supabase, role);
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

      // Root Route
      GoRoute(path: '/', redirect: (context, state) => '/splash'),
    ],
  );
});
