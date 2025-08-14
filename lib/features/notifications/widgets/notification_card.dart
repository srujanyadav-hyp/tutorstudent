import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    final isRead = notification['is_read'] ?? false;
    final type = notification['type'] ?? '';
    final title = notification['title'] ?? '';
    final message = notification['message'] ?? '';
    final createdAt = DateTime.tryParse(notification['created_at'] ?? '') ?? DateTime.now();

    return Card(
      elevation: isRead ? 1 : 3,
      shadowColor: isRead ? Colors.grey.withValues(alpha: 0.1) : Colors.blue.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isRead ? Colors.grey.shade200 : Colors.blue.shade200,
              width: isRead ? 1 : 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIcon(type, isRead),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(title, isRead),
                      const SizedBox(height: 4),
                      _buildMessage(message),
                      const SizedBox(height: 8),
                      _buildFooter(createdAt, isRead),
                    ],
                  ),
                ),
                if (!isRead) _buildMarkAsReadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(String type, bool isRead) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case 'session_reminder':
        iconData = Icons.calendar_today;
        iconColor = Colors.orange.shade600;
        break;
      case 'assignment_due':
        iconData = Icons.assignment;
        iconColor = Colors.red.shade600;
        break;
      case 'new_message':
        iconData = Icons.message;
        iconColor = Colors.blue.shade600;
        break;
      case 'payment_success':
        iconData = Icons.payment;
        iconColor = Colors.green.shade600;
        break;
      case 'tutor_available':
        iconData = Icons.person_add;
        iconColor = Colors.purple.shade600;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = Colors.grey.shade600;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: iconColor.withValues(alpha: 0.3),
        ),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24,
      ),
    );
  }

  Widget _buildHeader(String title, bool isRead) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
              color: isRead ? Colors.grey.shade700 : Colors.grey.shade800,
            ),
          ),
        ),
        if (!isRead)
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  Widget _buildMessage(String message) {
    return Text(
      message,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
        height: 1.4,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooter(DateTime createdAt, bool isRead) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    String timeAgo;
    if (difference.inMinutes < 60) {
      timeAgo = '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      timeAgo = '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      timeAgo = '${difference.inDays}d ago';
    } else {
      timeAgo = DateFormat('MMM dd').format(createdAt);
    }

    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 14,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 4),
        Text(
          timeAgo,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
          ),
        ),
        const Spacer(),
        if (!isRead)
          TextButton(
            onPressed: onMarkAsRead,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
            ),
            child: Text(
              'Mark as read',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMarkAsReadButton() {
    return IconButton(
      onPressed: onMarkAsRead,
      icon: Icon(
        Icons.check_circle_outline,
        color: Colors.grey.shade400,
        size: 20,
      ),
      tooltip: 'Mark as read',
    );
  }
}
