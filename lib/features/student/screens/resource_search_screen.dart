import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/student_scaffold.dart';

class ResourceSearchScreen extends ConsumerWidget {
  final String query;

  const ResourceSearchScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StudentScaffold(
      title: 'Search Results',
      currentIndex: 4, // Changed from 5 to 4 since we're in Resources section
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Search results for: $query'),
            ),
            const SizedBox(height: 200), // Added for better spacing
            const Center(child: Text('No results found')),
            const SizedBox(height: 200), // Added for better spacing
          ],
        ),
      ),
    );
  }
}
