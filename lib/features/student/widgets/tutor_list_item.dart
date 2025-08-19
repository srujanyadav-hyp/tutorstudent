import 'package:flutter/material.dart';

class TutorListItem extends StatelessWidget {
  final String tutorName;
  final String subject;
  final double monthlyFee;
  final VoidCallback onConnect;

  const TutorListItem({
    Key? key,
    required this.tutorName,
    required this.subject,
    required this.monthlyFee,
    required this.onConnect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tutorName, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Subject: $subject',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            _buildMonthlyFeeInfo(context),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onConnect,
                child: const Text('Connect'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyFeeInfo(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.attach_money, color: Colors.green),
        const SizedBox(width: 4),
        Text(
          'Monthly Fee: ₹${monthlyFee.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.green),
        ),
      ],
    );
  }
}
