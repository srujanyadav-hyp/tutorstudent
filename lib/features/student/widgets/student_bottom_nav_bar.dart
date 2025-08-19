import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const StudentBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex.clamp(0, 4),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      backgroundColor: Colors.white,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Tutors'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Sessions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Assignments',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Resources'),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/student/dashboard');
            break;
          case 1:
            context.go('/student/tutors');
            break;
          case 2:
            context.go('/student/sessions');
            break;
          case 3:
            context.go('/student/assignments');
            break;
          case 4:
            context.go('/student/resources');
            break;
        }
      },
    );
  }
}
