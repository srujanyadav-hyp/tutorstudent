import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignmentCard extends StatelessWidget {
  final Map<String, dynamic> assignment;

  const AssignmentCard({Key? key, required this.assignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime? dueDate = assignment['due_date'] != null
        ? DateTime.parse(assignment['due_date'])
        : null;
    final dateFormatter = DateFormat('MMM dd, yyyy');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            _getStatusIcon(assignment['status']),
            color: Colors.white,
          ),
          backgroundColor: _getStatusColor(assignment['status']),
        ),
        title: Text(assignment['title'] ?? 'Untitled Assignment'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (dueDate != null) Text('Due: ${dateFormatter.format(dueDate)}'),
            Text('Status: ${assignment['status']}'),
            if (assignment['score'] != null)
              Text('Score: ${assignment['score']}%'),
          ],
        ),
        onTap: () {
          // Navigate to assignment details
        },
      ),
    );
  }

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'pending':
        return Icons.assignment;
      case 'submitted':
        return Icons.assignment_turned_in;
      case 'graded':
        return Icons.grade;
      case 'overdue':
        return Icons.assignment_late;
      default:
        return Icons.help;
    }
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'submitted':
        return Colors.blue;
      case 'graded':
        return Colors.green;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
