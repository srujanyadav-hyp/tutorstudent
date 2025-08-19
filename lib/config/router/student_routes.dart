import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tutorconnect/features/student/screens/assignment_list_screen.dart';
import 'package:tutorconnect/features/student/screens/session_detail_screen.dart';
import 'package:tutorconnect/features/student/screens/live_session_screen.dart';
import 'package:tutorconnect/features/student/screens/assignment_detail_screen.dart';
import 'package:tutorconnect/features/student/screens/session_list_screen.dart';
import 'package:tutorconnect/features/student/screens/student_dashboard.dart';
import 'package:tutorconnect/features/student/screens/tutor_list_screen.dart';
import 'package:tutorconnect/features/student/screens/student_resources_screen.dart';
import 'package:tutorconnect/features/student/screens/resource_list_screen.dart';
import 'package:tutorconnect/features/student/screens/subject_resources_screen.dart';
import 'package:tutorconnect/features/student/screens/resource_search_screen.dart';

final studentRoutes = [
  GoRoute(
    path: '/student/dashboard',
    builder: (BuildContext context, GoRouterState state) {
      return const StudentDashboard();
    },
  ),
  GoRoute(
    path: '/student/tutors',
    builder: (BuildContext context, GoRouterState state) {
      return const TutorListScreen();
    },
  ),
  GoRoute(
    path: '/student/sessions',
    builder: (BuildContext context, GoRouterState state) {
      return const SessionListScreen();
    },
  ),
  GoRoute(
    path: '/student/assignments',
    builder: (BuildContext context, GoRouterState state) {
      return const AssignmentListScreen();
    },
  ),

  GoRoute(
    path: '/student/sessions/:id',
    builder: (BuildContext context, GoRouterState state) {
      final sessionId = state.pathParameters['id']!;
      return SessionDetailScreen(sessionId: sessionId);
    },
  ),
  GoRoute(
    path: '/student/sessions/:id/live',
    builder: (BuildContext context, GoRouterState state) {
      final sessionId = state.pathParameters['id']!;
      final studentId = Supabase.instance.client.auth.currentUser!.id;
      final extra = state.extra as Map<String, dynamic>;
      final tutorId = extra['tutorId'] as String;
      return LiveSessionScreen(
        sessionId: sessionId,
        tutorId: tutorId,
        studentId: studentId,
        isTutor: false,
      );
    },
  ),
  GoRoute(
    path: '/student/assignments/:id',
    builder: (BuildContext context, GoRouterState state) {
      final assignmentId = state.pathParameters['id']!;
      return AssignmentDetailScreen(assignmentId: assignmentId);
    },
  ),
  GoRoute(
    path: '/student/resources',
    builder: (BuildContext context, GoRouterState state) {
      return const StudentResourcesScreen();
    },
  ),
  GoRoute(
    path: '/student/resources/:type',
    builder: (BuildContext context, GoRouterState state) {
      final type = state.pathParameters['type']!;
      return ResourceListScreen(type: type);
    },
  ),
  GoRoute(
    path: '/student/resources/subjects/:subjectId',
    builder: (BuildContext context, GoRouterState state) {
      final subjectId = state.pathParameters['subjectId']!;
      return SubjectResourcesScreen(subjectId: subjectId);
    },
  ),
  GoRoute(
    path: '/student/resources/search',
    builder: (BuildContext context, GoRouterState state) {
      final query = state.uri.queryParameters['q'] ?? '';
      return ResourceSearchScreen(query: query);
    },
  ),
];
