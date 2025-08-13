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
import '../../features/student/screens/session_list_screen.dart';
import '../../features/student/screens/session_detail_screen.dart';
import '../../features/student/screens/assignment_list_screen.dart';
import '../../features/student/screens/assignment_detail_screen.dart';
import '../../features/student/screens/tutor_list_screen.dart';
import '../../features/student/screens/progress_screen.dart';

import '../../features/tutor/models/student_management.dart';
import '../../features/tutor/screens/student_detail_screen.dart';
import '../../models/user_role.dart';
import '../../providers/role_provider.dart';
import '../../features/messaging/config/chat_routes.dart';
import '../../features/live_session/screens/live_session_screen.dart';

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
        default:
          return '/student'; // Default fallback
      }
    }
    return null;
  }

  // For non-authenticated users
  if (!isAuth) {
    // Protect dashboard routes
    if (location.startsWith('/tutor') || location.startsWith('/student')) {
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
        routes: [
          GoRoute(
            path: 'student/:id',
            builder: (context, state) {
              final studentId = state.pathParameters['id']!;
              return StudentDetailScreen(
                studentId: studentId,
                student: state.extra as ManagedStudent,
              );
            },
          ),
          GoRoute(
            path: 'live-session/:sessionId',
            builder: (context, state) {
              final sessionId = state.pathParameters['sessionId']!;
              final tutorId = supabase.auth.currentUser!.id;
              final studentId =
                  (state.extra as Map<String, dynamic>)['studentId'] as String;
              return LiveSessionScreen(
                sessionId: sessionId,
                tutorId: tutorId,
                studentId: studentId,
                isTutor: true,
              );
            },
          ),
          ...chatRoutes,
        ],
      ),
      GoRoute(
        path: '/student',
        builder: (context, state) => const StudentDashboard(),
        routes: [
          GoRoute(
            path: 'sessions',
            builder: (context, state) => const SessionListScreen(),
          ),
          GoRoute(
            path: 'sessions/:id',
            builder: (context, state) {
              final sessionId = state.pathParameters['id']!;
              return SessionDetailScreen(sessionId: sessionId);
            },
          ),
          GoRoute(
            path: 'live-session/:sessionId',
            builder: (context, state) {
              final sessionId = state.pathParameters['sessionId']!;
              final studentId = supabase.auth.currentUser!.id;
              final tutorId =
                  (state.extra as Map<String, dynamic>)['tutorId'] as String;
              return LiveSessionScreen(
                sessionId: sessionId,
                tutorId: tutorId,
                studentId: studentId,
                isTutor: false,
              );
            },
          ),
          GoRoute(
            path: 'sessions/:id/live',
            builder: (context, state) {
              final sessionId = state.pathParameters['id']!;
              final studentId = supabase.auth.currentUser!.id;
              final tutorId =
                  (state.extra as Map<String, dynamic>)['tutorId'] as String;
              return LiveSessionScreen(
                sessionId: sessionId,
                tutorId: tutorId,
                studentId: studentId,
                isTutor: false,
              );
            },
          ),
          GoRoute(
            path: 'assignments',
            builder: (context, state) => const AssignmentListScreen(),
          ),
          GoRoute(
            path: 'assignments/:id',
            builder: (context, state) {
              final assignmentId = state.pathParameters['id']!;
              return AssignmentDetailScreen(assignmentId: assignmentId);
            },
          ),
          GoRoute(
            path: 'tutors',
            builder: (context, state) => const TutorListScreen(),
          ),
          GoRoute(
            path: 'progress',
            builder: (context, state) => const ProgressScreen(),
          ),
          ...chatRoutes,
        ],
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
