import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';
import '../widgets/session_card.dart';
import '../widgets/student_scaffold.dart';

class SessionListScreen extends ConsumerWidget {
  const SessionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final sessionsAsync = ref.watch(upcomingSessionsFilteredProvider(user.id));

    return StudentScaffold(
      title: 'My Sessions',
      currentIndex: 2,
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.filter_list),
          onSelected: (value) {
            switch (value) {
              case 'all':
                ref.read(sessionFilterProvider.notifier).state =
                    SessionFilter.all;
                break;
              case 'upcoming':
                ref.read(sessionFilterProvider.notifier).state =
                    SessionFilter.upcoming;
                break;
              case 'live':
                ref.read(sessionFilterProvider.notifier).state =
                    SessionFilter.live;
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'all', child: Text('All')),
            PopupMenuItem(value: 'upcoming', child: Text('Upcoming')),
            PopupMenuItem(value: 'live', child: Text('Live')),
          ],
        ),
      ],
      body: sessionsAsync.when(
        data: (sessions) {
          if (sessions.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No sessions scheduled'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.refresh(upcomingSessionsProvider(user.id).future),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sessions.length,
              itemBuilder: (context, index) =>
                  SessionCard(session: sessions[index]),
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
                    ref.refresh(upcomingSessionsProvider(user.id).future),
                child: const Text('RETRY'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
