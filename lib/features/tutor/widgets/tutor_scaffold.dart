import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TutorScaffold extends StatelessWidget {
  final String title;
  final int currentIndex;
  final List<Widget>? actions;
  final Widget body;
  final bool showBottomNavigation;

  const TutorScaffold({
    super.key,
    required this.title,
    required this.currentIndex,
    this.actions,
    required this.body,
    this.showBottomNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade800,
        actions: actions,
        centerTitle: true,
      ),
      body: body,
      bottomNavigationBar: showBottomNavigation ? _buildBottomNavigation(context) : null,
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onNavigationTap(context, index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Sessions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            activeIcon: Icon(Icons.attach_money),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _onNavigationTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        if (currentIndex != 0) {
          GoRouter.of(context).go('/tutor/dashboard');
        }
        break;
      case 1:
        if (currentIndex != 1) {
          GoRouter.of(context).go('/tutor/sessions');
        }
        break;
      case 2:
        if (currentIndex != 2) {
          GoRouter.of(context).go('/tutor/students');
        }
        break;
      case 3:
        if (currentIndex != 3) {
          GoRouter.of(context).go('/tutor/earnings');
        }
        break;
      case 4:
        if (currentIndex != 4) {
          GoRouter.of(context).go('/tutor/settings');
        }
        break;
    }
  }
}
