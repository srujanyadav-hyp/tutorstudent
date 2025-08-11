import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class SessionCard extends ConsumerWidget {
  final Map<String, dynamic> session;

  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy - hh:mm a');
    final scheduledAt = DateTime.parse(session['scheduled_at']);
    final now = DateTime.now();

    bool isLive =
        scheduledAt.isBefore(now) &&
        scheduledAt.add(const Duration(hours: 1)).isAfter(now);
    bool isUpcoming = scheduledAt.isAfter(now);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                isLive ? Icons.videocam : Icons.calendar_today,
                color: isLive ? Colors.red : null,
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    session['title'] ?? 'Tutoring Session',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                if (isLive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dateFormat.format(scheduledAt)),
                if (session['description'] != null)
                  Text(
                    session['description'],
                    style: theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (isLive || isUpcoming)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isLive)
                    ElevatedButton.icon(
                      icon: const Icon(Icons.videocam),
                      label: const Text('Join Session'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        context.push(
                          '/student/sessions/${session['id']}/live',
                          extra: {'tutorId': session['tutor_id']},
                        );
                      },
                    ),
                  if (isUpcoming) ...[
                    TextButton(
                      onPressed: () {
                        // TODO: Implement session cancellation
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.push('/student/sessions/${session['id']}');
                      },
                      child: const Text('View Details'),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
