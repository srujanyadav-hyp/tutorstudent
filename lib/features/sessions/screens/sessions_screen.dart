import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_provider.dart';
import '../widgets/session_card.dart';
import '../widgets/session_form.dart';
import '../models/tutor_session.dart';

class SessionsScreen extends ConsumerWidget {
  final String tutorId;

  const SessionsScreen({
    super.key,
    required this.tutorId,
  });

  void _showSessionForm(BuildContext context, WidgetRef ref,
      [TutorSession? session]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              session == null ? 'Create New Session' : 'Edit Session',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SessionForm(
              session: session,
              onSubmit: (title, description, scheduledAt, videoLink) async {
                if (session == null) {
                  await ref
                      .read(sessionNotifierProvider(tutorId).notifier)
                      .createSession(
                        title: title,
                        description: description,
                        scheduledAt: scheduledAt,
                        videoLink: videoLink,
                      );
                } else {
                  await ref
                      .read(sessionNotifierProvider(tutorId).notifier)
                      .updateSession(
                        session.copyWith(
                          title: title,
                          description: description,
                          scheduledAt: scheduledAt,
                          videoLink: videoLink,
                        ),
                      );
                }
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, String sessionId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Session'),
        content: const Text('Are you sure you want to delete this session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(sessionNotifierProvider(tutorId).notifier)
          .deleteSession(sessionId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(tutorSessionsProvider(tutorId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions'),
      ),
      body: sessionsAsync.when(
        data: (sessions) {
          if (sessions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No sessions yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _showSessionForm(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Create Session'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return SessionCard(
                session: session,
                onEdit: () => _showSessionForm(context, ref, session),
                onDelete: () => _confirmDelete(context, ref, session.id),
                onStatusChange: (status) {
                  ref
                      .read(sessionNotifierProvider(tutorId).notifier)
                      .updateSessionStatus(session.id, status);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSessionForm(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
