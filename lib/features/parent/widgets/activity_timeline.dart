import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> activities;

  const ActivityTimeline({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return _buildActivityItem(context, activity);
      },
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    Map<String, dynamic> activity,
  ) {
    final timestamp = DateTime.parse(activity['timestamp']);
    final type = activity['type'];
    final details = activity['details'];

    IconData icon;
    Color color;
    String title;

    switch (type) {
      case 'session':
        icon = Icons.class_;
        color = Colors.blue;
        title = 'New Session: ${details['title']}';
        break;
      case 'payment':
        icon = Icons.payment;
        color = details['status'] == 'paid' ? Colors.green : Colors.orange;
        title = 'Payment: \$${details['amount']} (${details['status']})';
        break;
      case 'progress':
        icon = Icons.trending_up;
        color = Colors.purple;
        title = 'Progress Update: ${details['subject']} - ${details['score']}%';
        break;
      default:
        icon = Icons.info;
        color = Colors.grey;
        title = 'Activity';
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title),
      subtitle: Text(
        DateFormat.yMMMd().add_jm().format(timestamp),
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      onTap: () {
        // TODO: Navigate to detail view based on activity type
      },
    );
  }
}

class ActivityTimelinePlaceholder extends StatelessWidget {
  const ActivityTimelinePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Container(),
          ),
          title: Container(
            height: 16,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          subtitle: Container(
            height: 12,
            width: 100,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      },
    );
  }
}
