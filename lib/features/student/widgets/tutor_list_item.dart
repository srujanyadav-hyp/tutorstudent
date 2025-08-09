import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TutorListItem extends StatelessWidget {
  final Map<String, dynamic> tutor;
  final VoidCallback onConnect;

  const TutorListItem({
    super.key,
    required this.tutor,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reviews = tutor['tutor_reviews'] as List;
    double averageRating = 0;

    if (reviews.isNotEmpty) {
      final total = reviews.fold<double>(
        0,
        (sum, review) => sum + (review['rating'] as num),
      );
      averageRating = total / reviews.length;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (tutor['profile_image'] != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(tutor['profile_image']),
                    radius: 30,
                  )
                else
                  const CircleAvatar(child: Icon(Icons.person), radius: 30),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tutor['full_name'],
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            '${averageRating.toStringAsFixed(1)} (${reviews.length})',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (tutor['bio'] != null) ...[
              const SizedBox(height: 16),
              Text(
                tutor['bio'],
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 16),
            if (tutor['role_specific_data'] != null) ...[
              _buildSpecificInfo(tutor['role_specific_data'], theme),
              const SizedBox(height: 16),
            ],
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onConnect,
                child: const Text('CONNECT'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificInfo(Map<String, dynamic> data, ThemeData theme) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (data['subjects'] != null)
          ...(data['subjects'] as List).map(
            (subject) => Chip(
              label: Text(subject),
              backgroundColor: theme.primaryColor.withOpacity(0.1),
              labelStyle: TextStyle(color: theme.primaryColor),
            ),
          ),
        if (data['experience'] != null)
          Chip(
            label: Text('${data['experience']} years'),
            backgroundColor: theme.primaryColor.withOpacity(0.1),
            labelStyle: TextStyle(color: theme.primaryColor),
          ),
      ],
    );
  }
}
