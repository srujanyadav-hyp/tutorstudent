import 'package:flutter/material.dart';
import '../models/student_management.dart';
import 'package:intl/intl.dart';

class StudentListItem extends StatelessWidget {
  final ManagedStudent student;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onRemove;

  const StudentListItem({
    super.key,
    required this.student,
    this.onTap,
    this.onEdit,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(student.name, style: theme.textTheme.titleLarge),
                        if (student.grade != null ||
                            student.subjects != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            [
                              if (student.grade != null)
                                'Grade ${student.grade}',
                              if (student.subjects != null) student.subjects,
                            ].join(' • '),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (student.isActive)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatItem(
                    Icons.check_circle_outline,
                    'Completed',
                    student.completedSessions.toString(),
                    theme,
                  ),
                  const SizedBox(width: 24),
                  _buildStatItem(
                    Icons.upcoming,
                    'Upcoming',
                    student.upcomingSessions.toString(),
                    theme,
                  ),
                  const SizedBox(width: 24),
                  _buildStatItem(
                    Icons.trending_up,
                    'Performance',
                    '${(student.averagePerformance * 100).toInt()}%',
                    theme,
                  ),
                ],
              ),
              if (student.lastSessionDate != null) ...[
                const SizedBox(height: 16),
                Text(
                  'Last Session: ${dateFormat.format(student.lastSessionDate!)}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onEdit != null)
                    IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
                  if (onRemove != null)
                    IconButton(
                      icon: const Icon(Icons.person_remove),
                      color: Colors.red,
                      onPressed: onRemove,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String label,
    String value,
    ThemeData theme,
  ) {
    return Column(
      children: [
        Icon(icon, size: 20, color: theme.primaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
