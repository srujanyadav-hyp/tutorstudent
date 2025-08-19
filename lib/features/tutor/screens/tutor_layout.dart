import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../sessions/screens/sessions_screen.dart';
import '../../profile/screens/profile_screen.dart';
import 'tutor_dashboard_content.dart';
import 'tutor_students_screen.dart';
import 'tutor_resource_upload_screen.dart';
import '../../../core/services/supabase_service.dart';

class TutorLayout extends ConsumerStatefulWidget {
  const TutorLayout({super.key});

  @override
  ConsumerState<TutorLayout> createState() => _TutorLayoutState();
}

class _TutorLayoutState extends ConsumerState<TutorLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userId = SupabaseService().client.auth.currentUser?.id;
    if (userId == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final screens = [
      const TutorDashboardContent(),
      SessionsScreen(tutorId: userId),
      const TutorStudentsScreen(),
      const TutorResourceUploadScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Sessions',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Students'),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file),
            label: 'Resources',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
