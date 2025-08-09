import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionCard extends StatelessWidget {
  final Map<String, dynamic> session;

  const SessionCard({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime scheduledAt = DateTime.parse(session['scheduled_at']);
    final dateFormatter = DateFormat('MMM dd, yyyy');
    final timeFormatter = DateFormat('hh:mm a');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(_getStatusIcon(session['status']), color: Colors.white),
          backgroundColor: _getStatusColor(session['status']),
        ),
        title: Text(session['title'] ?? 'Untitled Session'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${dateFormatter.format(scheduledAt)}'),
            Text('Time: ${timeFormatter.format(scheduledAt)}'),
            Text('Status: ${session['status']}'),
          ],
        ),
        onTap: () {
          // Navigate to session details
        },
      ),
    );
  }

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'upcoming':
        return Icons.schedule;
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'upcoming':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
