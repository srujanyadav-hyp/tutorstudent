import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';
import '../widgets/tutor_list_item.dart';
import '../widgets/student_scaffold.dart';

class TutorListScreen extends ConsumerWidget {
  const TutorListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final tutorsAsync = ref.watch(availableTutorsFilteredProvider);

    return StudentScaffold(
      title: 'Find Tutors',
      currentIndex: 1,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            final query = await showSearch<String>(
              context: context,
              delegate: _TutorSearchDelegate(),
            );
            if (query != null) {
              ref.read(tutorSearchQueryProvider.notifier).state = query;
            }
          },
        ),
      ],
      body: tutorsAsync.when(
        data: (tutors) {
          if (tutors.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No tutors available'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(availableTutorsProvider.future),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tutors.length,
              itemBuilder: (context, index) {
                final tutor = tutors[index];
                return TutorListItem(
                  tutor: tutor,
                  onConnect: () async {
                    try {
                      await ref
                          .read(studentNotifierProvider(user.id).notifier)
                          .connectWithTutor(tutor['id']);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Successfully connected with tutor'),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                );
              },
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
                onPressed: () => ref.refresh(availableTutorsProvider),
                child: const Text('RETRY'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TutorSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, query),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text('Search tutors for "$query"'),
    );
  }
}
