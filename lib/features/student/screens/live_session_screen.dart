import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../live_session/screens/live_session_screen.dart' as core_live;
import '../widgets/student_scaffold.dart';

// Thin wrapper to route students into the core live session UI
class LiveSessionScreen extends ConsumerWidget {
  final String sessionId;
  final String tutorId;
  final String studentId;
  final bool isTutor;

  const LiveSessionScreen({
    super.key,
    required this.sessionId,
    required this.tutorId,
    required this.studentId,
    required this.isTutor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StudentScaffold(
      title: 'Live Session',
      currentIndex: 2,
      body: core_live.LiveSessionScreen(
        sessionId: sessionId,
        tutorId: tutorId,
        studentId: studentId,
        isTutor: isTutor,
      ),
    );
  }
}
