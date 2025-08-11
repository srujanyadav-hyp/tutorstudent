import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';
import '../widgets/assignment_card.dart';
import '../widgets/student_scaffold.dart';

class AssignmentListScreen extends ConsumerWidget {
  const AssignmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final assignmentsAsync = ref.watch(assignmentsFilteredProvider(user.id));

    return StudentScaffold(
      title: 'My Assignments',
      currentIndex: 3,
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.filter_list),
          onSelected: (value) {
            switch (value) {
              case 'all':
                ref.read(assignmentFilterProvider.notifier).state =
                    AssignmentFilter.all;
                break;
              case 'pending':
                ref.read(assignmentFilterProvider.notifier).state =
                    AssignmentFilter.pending;
                break;
              case 'submitted':
                ref.read(assignmentFilterProvider.notifier).state =
                    AssignmentFilter.submitted;
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'all', child: Text('All')),
            PopupMenuItem(value: 'pending', child: Text('Pending')),
            PopupMenuItem(value: 'submitted', child: Text('Submitted')),
          ],
        ),
      ],
      body: assignmentsAsync.when(
        data: (assignments) {
          if (assignments.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No assignments yet'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(assignmentsProvider(user.id).future),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: assignments.length,
              itemBuilder: (context, index) =>
                  AssignmentCard(assignment: assignments[index]),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.refresh(assignmentsProvider(user.id).future),
                child: const Text('RETRY'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
