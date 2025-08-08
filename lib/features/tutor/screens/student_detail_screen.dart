import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/student_management.dart';
import '../providers/student_management_provider.dart';

class StudentDetailScreen extends ConsumerWidget {
  final String studentId;
  final ManagedStudent student;

  const StudentDetailScreen({
    super.key,
    required this.studentId,
    required this.student,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');
    final progressAsync = ref.watch(studentProgressProvider(studentId));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(student.name),
            if (student.grade != null || student.subjects != null)
              Text(
                [
                  if (student.grade != null) 'Grade ${student.grade}',
                  if (student.subjects != null) student.subjects,
                ].join(' • '),
                style: theme.textTheme.bodyMedium,
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Show edit student dialog
              showDialog(
                context: context,
                builder: (context) => EditStudentDialog(student: student),
              );
            },
          ),
        ],
      ),
      body: progressAsync.when(
        data: (progress) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(context),
              const SizedBox(height: 24),
              Text('Subject Performance', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              _buildSubjectPerformance(context, progress),
              const SizedBox(height: 24),
              Text('Session History', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              _buildSessionHistory(context, progress),
              const SizedBox(height: 24),
              Text('Assignments', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              _buildAssignments(context, progress),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Error loading student progress',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.refresh(studentProgressProvider(studentId));
                },
                child: const Text('RETRY'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
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
                      Text(student.email, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      if (student.lastSessionDate != null)
                        Text(
                          'Last Session: ${DateFormat('MMM dd, yyyy').format(student.lastSessionDate!)}',
                          style: theme.textTheme.bodyMedium,
                        ),
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
                      color: Colors.green.withOpacity(0.1),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn(
                  'Completed',
                  student.completedSessions.toString(),
                  Icons.check_circle_outline,
                  theme,
                ),
                _buildStatColumn(
                  'Upcoming',
                  student.upcomingSessions.toString(),
                  Icons.upcoming,
                  theme,
                ),
                _buildStatColumn(
                  'Performance',
                  '${(student.averagePerformance * 100).round()}%',
                  Icons.trending_up,
                  theme,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(
    String label,
    String value,
    IconData icon,
    ThemeData theme,
  ) {
    return Column(
      children: [
        Icon(icon, size: 24, color: theme.primaryColor),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.titleLarge),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }

  Widget _buildSubjectPerformance(
    BuildContext context,
    StudentProgress progress,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: progress.subjectPerformance.entries.map((entry) {
            final performance = entry.value;
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.key,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      '${(performance * 100).round()}%',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: performance,
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSessionHistory(BuildContext context, StudentProgress progress) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: progress.sessionHistory.length,
        itemBuilder: (context, index) {
          final session = progress.sessionHistory[index];
          return ListTile(
            leading: Icon(
              session.attended ? Icons.check_circle : Icons.cancel,
              color: session.attended ? Colors.green : Colors.red,
            ),
            title: Text(dateFormat.format(session.date)),
            subtitle: session.notes != null ? Text(session.notes!) : null,
          );
        },
      ),
    );
  }

  Widget _buildAssignments(BuildContext context, StudentProgress progress) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: progress.assignments.length,
        itemBuilder: (context, index) {
          final assignment = progress.assignments[index];
          return ListTile(
            title: Text(assignment.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Due: ${dateFormat.format(assignment.dueDate)}'),
                if (assignment.feedback != null)
                  Text(assignment.feedback!, style: theme.textTheme.bodySmall),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(assignment.score * 100).round()}%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  assignment.completed
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  color: assignment.completed ? Colors.green : Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
