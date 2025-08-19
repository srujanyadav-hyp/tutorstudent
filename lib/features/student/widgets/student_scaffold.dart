import 'package:flutter/material.dart';
import 'student_bottom_nav_bar.dart';

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
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.grey[800],
        actions: actions,
        centerTitle: true,
      ),
      body: body,
      bottomNavigationBar: StudentBottomNavBar(currentIndex: currentIndex),
    );
  }
}
