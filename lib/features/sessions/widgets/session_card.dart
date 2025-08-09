import 'package:flutter/material.dart';
import '../models/session.dart';
import 'package:intl/intl.dart';

class SessionCard extends StatelessWidget {
  final Session session;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Function(SessionStatus)? onStatusChange;

  const SessionCard({
    super.key,
    required this.session,
    this.onEdit,
    this.onDelete,
    this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    Color statusColor;
    switch (session.status) {
      case SessionStatus.scheduled:
        statusColor = Colors.blue;
        break;
      case SessionStatus.inProgress:
        statusColor = Colors.green;
        break;
      case SessionStatus.completed:
        statusColor = Colors.grey;
        break;
      case SessionStatus.cancelled:
        statusColor = Colors.red;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(session.title, style: theme.textTheme.titleLarge),
                ),
                PopupMenuButton<SessionStatus>(
                  onSelected: onStatusChange,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: SessionStatus.scheduled,
                      child: const Text('Mark as Scheduled'),
                    ),
                    PopupMenuItem(
                      value: SessionStatus.inProgress,
                      child: const Text('Mark as In Progress'),
                    ),
                    PopupMenuItem(
                      value: SessionStatus.completed,
                      child: const Text('Mark as Completed'),
                    ),
                    PopupMenuItem(
                      value: SessionStatus.cancelled,
                      child: const Text('Mark as Cancelled'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (session.description != null) ...[
              Text(session.description!, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
            ],
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: theme.primaryColor),
                const SizedBox(width: 4),
                Text(
                  dateFormat.format(session.scheduledAt),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: theme.primaryColor),
                const SizedBox(width: 4),
                Text(
                  timeFormat.format(session.scheduledAt),
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    session.status.name.toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                if (onEdit != null)
                  IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
              ],
            ),
            if (session.videoLink != null) ...[
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement video link handling
                },
                icon: const Icon(Icons.video_call),
                label: const Text('Join Session'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
