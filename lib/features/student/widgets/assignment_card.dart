import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class AssignmentCard extends StatelessWidget {
  final Map<String, dynamic> assignment;

  const AssignmentCard({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');
    final dueDate = DateTime.parse(assignment['due_date']);
    final isSubmitted = assignment['submitted_at'] != null;
    final score = assignment['score'];
    final isOverdue = dueDate.isBefore(DateTime.now()) && !isSubmitted;
    final daysUntilDue = dueDate.difference(DateTime.now()).inDays;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getBorderColor(isSubmitted, isOverdue, score),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.push('/student/assignments/${assignment['id']}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildStatusIcon(isSubmitted, isOverdue, score),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignment['title'] ?? 'Untitled Assignment',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          assignment['subject'] ?? 'General',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildScoreBadge(score, theme),
                ],
              ),
              const SizedBox(height: 12),
              _buildDueDateInfo(
                dueDate,
                dateFormat,
                isOverdue,
                daysUntilDue,
                theme,
              ),
              const SizedBox(height: 12),
              _buildProgressBar(assignment, theme),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTutorInfo(assignment, theme),
                  _buildActionButton(isSubmitted, isOverdue, context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(bool isSubmitted, bool isOverdue, dynamic score) {
    IconData icon;
    Color backgroundColor;
    Color iconColor;

    if (isSubmitted) {
      if (score != null && score >= 0.8) {
        icon = Icons.check_circle;
        backgroundColor = Colors.green.shade100;
        iconColor = Colors.green.shade700;
      } else if (score != null && score >= 0.6) {
        icon = Icons.check_circle_outline;
        backgroundColor = Colors.orange.shade100;
        iconColor = Colors.orange.shade700;
      } else {
        icon = Icons.check_circle_outline;
        backgroundColor = Colors.red.shade100;
        iconColor = Colors.red.shade700;
      }
    } else if (isOverdue) {
      icon = Icons.warning;
      backgroundColor = Colors.red.shade100;
      iconColor = Colors.red.shade700;
    } else {
      icon = Icons.schedule;
      backgroundColor = Colors.blue.shade100;
      iconColor = Colors.blue.shade700;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }

  Widget _buildScoreBadge(dynamic score, ThemeData theme) {
    if (score == null) return const SizedBox.shrink();

    final percentage = (score * 100).round();
    Color badgeColor;
    if (percentage >= 80) {
      badgeColor = Colors.green;
    } else if (percentage >= 60) {
      badgeColor = Colors.orange;
    } else {
      badgeColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        '$percentage%',
        style: theme.textTheme.bodySmall?.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDueDateInfo(
    DateTime dueDate,
    DateFormat dateFormat,
    bool isOverdue,
    int daysUntilDue,
    ThemeData theme,
  ) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 16,
          color: isOverdue ? Colors.red.shade600 : Colors.grey.shade600,
        ),
        const SizedBox(width: 6),
        Text(
          'Due: ${dateFormat.format(dueDate)}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isOverdue ? Colors.red.shade600 : Colors.grey.shade700,
            fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(width: 12),
        if (!isOverdue && daysUntilDue >= 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: daysUntilDue <= 3
                  ? Colors.orange.shade100
                  : Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              daysUntilDue == 0 ? 'Today' : '${daysUntilDue}d left',
              style: theme.textTheme.bodySmall?.copyWith(
                color: daysUntilDue <= 3
                    ? Colors.orange.shade700
                    : Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (isOverdue)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Overdue',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProgressBar(Map<String, dynamic> assignment, ThemeData theme) {
    final progress = assignment['progress'] ?? 0.0;
    final maxProgress = assignment['max_progress'] ?? 1.0;
    final currentProgress = progress / maxProgress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(currentProgress * 100).round()}%',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: currentProgress.clamp(0.0, 1.0),
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(
            currentProgress >= 1.0 ? Colors.green : theme.colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildTutorInfo(Map<String, dynamic> assignment, ThemeData theme) {
    final tutorName = assignment['tutor_name'] ?? 'Unknown Tutor';

    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(Icons.person, size: 16, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 6),
        Text(
          tutorName,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    bool isSubmitted,
    bool isOverdue,
    BuildContext context,
  ) {
    if (isSubmitted) {
      return TextButton.icon(
        onPressed: () {
          context.push('/student/assignments/${assignment['id']}');
        },
        icon: const Icon(Icons.visibility, size: 16),
        label: const Text('View'),
        style: TextButton.styleFrom(foregroundColor: Colors.blue.shade700),
      );
    } else if (isOverdue) {
      return ElevatedButton.icon(
        onPressed: () {
          context.push('/student/assignments/${assignment['id']}');
        },
        icon: const Icon(Icons.upload, size: 16),
        label: const Text('Submit Now'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      );
    } else {
      return ElevatedButton.icon(
        onPressed: () {
          context.push('/student/assignments/${assignment['id']}');
        },
        icon: const Icon(Icons.edit, size: 16),
        label: const Text('Work on it'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      );
    }
  }

  Color _getBorderColor(bool isSubmitted, bool isOverdue, dynamic score) {
    if (isOverdue) return Colors.red.shade300;
    if (isSubmitted) {
      if (score != null && score >= 0.8) return Colors.green.shade300;
      if (score != null && score >= 0.6) return Colors.orange.shade300;
      return Colors.red.shade300;
    }
    return Colors.grey.shade300;
  }
}
