import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/student_scaffold.dart';

class LiveSessionScreen extends ConsumerWidget {
  final String sessionId;

  const LiveSessionScreen({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StudentScaffold(
      title: 'Live Session',
      currentIndex: 2,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Implement live video session UI
            const Icon(Icons.videocam, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Joining session...', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.call_end),
              label: const Text('End Session'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              onPressed: () {
                // TODO: Implement session ending logic
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
