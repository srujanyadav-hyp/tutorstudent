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

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isSubmitted ? Colors.green : Colors.orange,
          child: Icon(
            isSubmitted ? Icons.check : Icons.pending,
            color: Colors.white,
          ),
        ),
        title: Text(assignment['title'], style: theme.textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Due: ${dateFormat.format(dueDate)}'),
            if (score != null)
              Text(
                'Score: ${((score as num) * 100).round()}%',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            context.push('/student/assignments/${assignment['id']}');
          },
        ),
      ),
    );
  }
}
