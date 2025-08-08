import 'package:flutter/material.dart';

class TutorStudentsScreen extends StatelessWidget {
  const TutorStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Students'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Student Management Coming Soon'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement add student functionality
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}
