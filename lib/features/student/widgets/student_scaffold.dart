import 'package:flutter/material.dart';
import 'package:tutorconnect/features/student/widgets/student_bottom_nav_bar.dart';

class StudentScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final String title;
  final List<Widget>? actions;

  const StudentScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: body,
      bottomNavigationBar: StudentBottomNavBar(currentIndex: currentIndex),
    );
  }
}
