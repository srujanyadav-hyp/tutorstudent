import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';
import '../widgets/student_scaffold.dart';

class SessionListScreen extends ConsumerWidget {
  const SessionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return const Center(child: Text('Not authenticated'));
    }

    final sessionsAsync = ref.watch(upcomingSessionsProvider(user.id));

    return StudentScaffold(
      title: 'Sessions',
      currentIndex: 2,
      body: sessionsAsync.when(
              data: (sessions) {
                if (sessions.isEmpty) {
            return _buildEmptyState(context);
          }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return _buildSessionCard(context, session);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No sessions scheduled',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Your upcoming sessions will appear here',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard(BuildContext context, Map<String, dynamic> session) {
    final scheduledAt = session['scheduled_at'];
    final isUpcoming =
        scheduledAt != null &&
        DateTime.parse(scheduledAt).isAfter(DateTime.now());

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isUpcoming ? Colors.blue : Colors.grey,
          child: Icon(
            isUpcoming ? Icons.calendar_today : Icons.calendar_today_outlined,
            color: Colors.white,
          ),
        ),
        title: Text(
          session['title'] ?? 'Session',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (scheduledAt != null)
              Text(
                _formatDateTime(scheduledAt),
                style: TextStyle(color: Colors.grey[600]),
              ),
            if (session['tutor_name'] != null)
              Text(
                'with ${session['tutor_name']}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
          ],
        ),
        trailing: isUpcoming
            ? ElevatedButton(
                onPressed: () => _joinSession(context, session),
                child: const Text('Join'),
              )
            : const Icon(Icons.check_circle, color: Colors.green),
        onTap: () => _viewSessionDetails(context, session),
      ),
    );
  }

  String _formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final now = DateTime.now();
      final difference = dateTime.difference(now);

      if (difference.inDays > 0) {
        return '${difference.inDays} days from now';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours from now';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes from now';
      } else {
        return 'Starting now';
      }
    } catch (e) {
      return dateTimeString;
    }
  }

  void _viewSessionDetails(BuildContext context, Map<String, dynamic> session) {
    final sessionId = session['id'];
    if (sessionId != null) {
      context.push('/student/sessions/$sessionId');
    }
  }

  void _joinSession(BuildContext context, Map<String, dynamic> session) {
    final sessionId = session['id'];
    final tutorId = session['tutor_id'];

    if (sessionId != null && tutorId != null) {
      context.push(
        '/student/sessions/$sessionId/live',
        extra: {'tutorId': tutorId},
      );
    }
  }
}
