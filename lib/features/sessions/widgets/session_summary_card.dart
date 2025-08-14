import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionSummaryCard extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final String duration;
  final String subject;
  final double totalCost;

  const SessionSummaryCard({
    super.key,
    required this.date,
    required this.time,
    required this.duration,
    required this.subject,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.blue.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.indigo.shade50,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.summarize,
                      color: Colors.blue.shade700,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Session Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildSummaryRow('Date', DateFormat('EEEE, MMMM dd, yyyy').format(date)),
              const SizedBox(height: 12),
              _buildSummaryRow('Time', time.format(context)),
              const SizedBox(height: 12),
              _buildSummaryRow('Duration', duration),
              const SizedBox(height: 12),
              _buildSummaryRow('Subject', subject),
              const Divider(height: 32),
              _buildTotalRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow() {
    return Row(
      children: [
        Text(
          'Total Cost',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          '\$${totalCost.toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.green.shade700,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
