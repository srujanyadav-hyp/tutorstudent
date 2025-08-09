import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/parent_dashboard_stats.dart';
import 'stats_card.dart';

class StatsGrid extends ConsumerWidget {
  final ParentDashboardStats stats;

  const StatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        StatsCard(
          title: 'Linked Students',
          value: stats.totalStudents.toString(),
          icon: Icons.people_outline,
          color: theme.colorScheme.primary,
        ),
        StatsCard(
          title: 'Upcoming Sessions',
          value: stats.upcomingSessions.toString(),
          icon: Icons.calendar_today,
          color: theme.colorScheme.secondary,
        ),
        StatsCard(
          title: 'Total Spent',
          value: '\$${stats.totalSpent.toStringAsFixed(2)}',
          icon: Icons.account_balance_wallet_outlined,
          color: theme.colorScheme.tertiary,
        ),
        StatsCard(
          title: 'Pending Payments',
          value: stats.pendingPayments.toString(),
          icon: Icons.payment_outlined,
          color: stats.pendingPayments > 0
              ? Colors.red
              : theme.colorScheme.primary,
        ),
      ],
    );
  }
}

class StatsGridPlaceholder extends StatelessWidget {
  const StatsGridPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: List.generate(
        4,
        (index) => Card(
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 14,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 24,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
