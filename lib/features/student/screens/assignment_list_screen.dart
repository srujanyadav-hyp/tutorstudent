import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';
import '../widgets/assignment_card.dart';
import '../widgets/student_scaffold.dart';
import '../widgets/error_view.dart';

class AssignmentListScreen extends ConsumerWidget {
  const AssignmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return Scaffold(
        body: ErrorView(
          message: 'You need to be signed in to view assignments.',
          onRetry: () => ref.refresh(supabaseServiceProvider),
        ),
      );
    }

    final assignmentsAsync = ref.watch(assignmentsProvider(user.id));

    return StudentScaffold(
      title: 'My Assignments',
      currentIndex: 3,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            // TODO: Implement assignment filtering
          },
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
        loading: () =>
            const LoadingView(message: 'Loading your assignments...'),
        error: (error, stack) => ErrorView(
          message: 'Failed to load assignments: ${error.toString()}',
          onRetry: () => ref.refresh(assignmentsProvider(user.id)),
        ),
      ),
    );
  }
}
