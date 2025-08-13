import 'package:flutter/material.dart';

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
                  const CircleAvatar(radius: 30, child: Icon(Icons.person)),
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
            if (tutor['tutor_subjects'] != null &&
                (tutor['tutor_subjects'] as List).isNotEmpty) ...[
              _buildFeesInfo(tutor['tutor_subjects'], theme),
              const SizedBox(height: 16),
            ],
            if (tutor['role_specific_data'] != null) ...[
              _buildSpecificInfo(tutor['role_specific_data'], theme),
              const SizedBox(height: 16),
            ],
            if (tutor['tutor_subjects'] != null &&
                (tutor['tutor_subjects'] as List).isNotEmpty) ...[
              _buildCostSummary(tutor['tutor_subjects'], theme),
              const SizedBox(height: 16),
            ],
            Row(
              children: [
                // Connection status indicator
                if (tutor['is_connected'] == true)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 16, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          'Connected',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                ElevatedButton(
                  onPressed: tutor['is_connected'] == true ? null : onConnect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tutor['is_connected'] == true
                        ? Colors.grey
                        : null,
                  ),
                  child: Text(
                    tutor['is_connected'] == true ? 'CONNECTED' : 'CONNECT',
                  ),
                ),
              ],
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
              backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
              labelStyle: TextStyle(color: theme.primaryColor),
            ),
          ),
        if (data['experience'] != null)
          Chip(
            label: Text('${data['experience']} years'),
            backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
            labelStyle: TextStyle(color: theme.primaryColor),
          ),
      ],
    );
  }

  Widget _buildFeesInfo(List<dynamic> subjects, ThemeData theme) {
    // Calculate total cost for all subjects
    final rates = subjects
        .where((subject) => subject['hourly_rate'] != null)
        .map((subject) => (subject['hourly_rate'] as num).toDouble())
        .toList();

    final totalCost = rates.isNotEmpty ? rates.reduce((a, b) => a + b) : 0.0;
    final averageRate = rates.isNotEmpty ? totalCost / rates.length : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.attach_money, size: 20, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              'Hourly Rates',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const Spacer(),
            if (rates.length > 1)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Avg: ₹${averageRate.toStringAsFixed(0)}/hr',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: subjects.map((subject) {
            final subjectData = subject as Map<String, dynamic>;
            final subjectName = subjectData['subject_name'] ?? 'Unknown';
            final hourlyRate = subjectData['hourly_rate'];
            final gradeLevel = subjectData['grade_level'];

            if (hourlyRate == null) return const SizedBox.shrink();

            return Chip(
              label: Text(
                '$subjectName: ₹${hourlyRate.toStringAsFixed(0)}/hr',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.green.withValues(alpha: 0.1),
              labelStyle: TextStyle(color: Colors.green.shade700),
              avatar: gradeLevel != null
                  ? CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      radius: 10,
                      child: Text(
                        gradeLevel.toString().substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    )
                  : null,
            );
          }).toList(),
        ),
        if (rates.length > 1) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This tutor teaches ${rates.length} subjects. Connection fee is based on average hourly rate.',
                    style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCostSummary(List<dynamic> subjects, ThemeData theme) {
    // Calculate average hourly rate for connection fee
    final rates = subjects
        .where((subject) => subject['hourly_rate'] != null)
        .map((subject) => (subject['hourly_rate'] as num).toDouble())
        .toList();

    if (rates.isEmpty) return const SizedBox.shrink();

    final averageRate = rates.reduce((a, b) => a + b) / rates.length;
    final connectionFee = averageRate; // Connection fee is 1 hour worth

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.credit_card, size: 20, color: Colors.purple),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Cost Breakdown',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connection Fee',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.purple.shade600,
                      ),
                    ),
                    Text(
                      '₹${connectionFee.toStringAsFixed(0)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.purple.withValues(alpha: 0.2),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Per Session (1hr)',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.purple.shade600,
                      ),
                    ),
                    Text(
                      '₹${averageRate.toStringAsFixed(0)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 14, color: Colors.purple),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Connection fee covers your first session. Additional sessions charged separately.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.purple.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
