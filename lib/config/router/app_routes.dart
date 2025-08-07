import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/forget_password_screen.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/onboarding/screens/role_selection_screen.dart';
import '../../features/tutor/screens/tutor_dashboard.dart';
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

  // Define public routes
  final isPublicRoute =
      location == '/splash' ||
      location == '/onboarding' ||
      location == '/select-role' ||
      location == '/login' ||
      location == '/signup' ||
      location == '/forgot-password';

  // If trying to access signup without role selected, redirect to role selection
  if (location == '/signup' && role == null) {
    return '/select-role';
  }

  // For authenticated users with role
  if (isAuth && role != null) {
    // Don't redirect if user is trying to logout
    if (location == '/login') return null;

    // Redirect to dashboard if trying to access auth or onboarding screens
    if (isPublicRoute) {
      switch (role) {
        case UserRole.tutor:
          return '/tutor';
        case UserRole.student:
          return '/student';
        case UserRole.parent:
          return '/parent';
      }
    }
  }

  // For authenticated users without role
  if (isAuth && role == null && location == '/signup') {
    return '/select-role';
  }

  // For unauthenticated users
  if (!isAuth) {
    // Allow public routes
    if (isPublicRoute) return null;
    // Redirect to onboarding for other routes
    return '/onboarding';
  }

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
