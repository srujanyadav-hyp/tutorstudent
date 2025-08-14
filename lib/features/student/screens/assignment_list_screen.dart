import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';
import '../widgets/assignment_card.dart';
import '../widgets/student_scaffold.dart';

class AssignmentListScreen extends ConsumerStatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  ConsumerState<AssignmentListScreen> createState() =>
      _AssignmentListScreenState();
}

class _AssignmentListScreenState extends ConsumerState<AssignmentListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final assignmentsAsync = ref.watch(assignmentsFilteredProvider(user.id));

    return StudentScaffold(
      title: 'My Assignments',
      currentIndex: 3,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearchDialog(context),
        ),
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
              case 'overdue':
                ref.read(assignmentFilterProvider.notifier).state =
                    AssignmentFilter.overdue;
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'all', child: Text('All')),
            PopupMenuItem(value: 'pending', child: Text('Pending')),
            PopupMenuItem(value: 'submitted', child: Text('Submitted')),
            PopupMenuItem(value: 'overdue', child: Text('Overdue')),
          ],
        ),
      ],
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: assignmentsAsync.when(
              data: (assignments) {
                if (assignments.isEmpty) {
                  return _buildEmptyState();
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(assignmentsProvider(user.id).future),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: assignments.length,
                    itemBuilder: (context, index) =>
                        AssignmentCard(assignment: assignments[index]),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => _buildErrorState(error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('All', AssignmentFilter.all),
            const SizedBox(width: 8),
            _buildFilterChip('Pending', AssignmentFilter.pending),
            const SizedBox(width: 8),
            _buildFilterChip('Submitted', AssignmentFilter.submitted),
            const SizedBox(width: 8),
            _buildFilterChip('Overdue', AssignmentFilter.overdue),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, AssignmentFilter filter) {
    final currentFilter = ref.watch(assignmentFilterProvider);
    final isSelected = currentFilter == filter;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        ref.read(assignmentFilterProvider.notifier).state = filter;
      },
      selectedColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.2),
      checkmarkColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.assignment_outlined,
              size: 64,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No assignments yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your assignments will appear here once they\'re assigned',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red.shade400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.red.shade700),
          ),
          const SizedBox(height: 8),
          Text(
            'Error: $error',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => ref.refresh(
              assignmentsProvider(
                ref.read(supabaseServiceProvider).client.auth.currentUser!.id,
              ).future,
            ),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Assignments'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search by title, subject, or description...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              // _searchQuery = value; // This line is removed
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement search functionality
              Navigator.pop(context);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
