import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../tutor/models/tutor_stats.dart';
import '../providers/tutor_dashboard_provider.dart';

class TutorDashboardView extends ConsumerWidget {
  final String tutorId;

  const TutorDashboardView({super.key, required this.tutorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(tutorDashboardProvider(tutorId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh dashboard',
            onPressed: () {
              ref.invalidate(tutorDashboardProvider(tutorId));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(tutorDashboardProvider(tutorId));
        },
        child: statsAsync.when(
          data: (stats) => _DashboardContent(stats: stats),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading dashboard',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(tutorDashboardProvider(tutorId));
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final TutorStats stats;

  const _DashboardContent({required this.stats});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCards(context, constraints),
            const SizedBox(height: 16),
            _buildSessionChart(context, constraints),
            const SizedBox(height: 16),
            _buildEarningsChart(context, constraints),
            const SizedBox(height: 8), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards(BuildContext context, BoxConstraints constraints) {
    final numberFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    final width = constraints.maxWidth;
    final crossAxisCount = width < 600 ? 2 : 3;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: width < 600 ? 1.6 : 1.4,
      children: [
        _StatCard(
          title: 'Total Sessions',
          value: stats.totalSessions.toString(),
          icon: Icons.calendar_today,
        ),
        _StatCard(
          title: 'Monthly Earnings',
          value: numberFormat.format(stats.monthlyEarnings),
          icon: Icons.attach_money,
        ),
        _StatCard(
          title: 'Total Students',
          value: stats.totalStudents.toString(),
          icon: Icons.people,
        ),
        _StatCard(
          title: 'Upcoming Sessions',
          value: stats.upcomingSessions.toString(),
          icon: Icons.event,
        ),
        _StatCard(
          title: 'Total Earnings',
          value: numberFormat.format(stats.totalEarnings),
          icon: Icons.monetization_on,
        ),
        _StatCard(
          title: 'Rating',
          value:
              '${stats.averageRating.toStringAsFixed(1)} (${stats.totalReviews})',
          icon: Icons.star,
        ),
      ],
    );
  }

  Widget _buildSessionChart(BuildContext context, BoxConstraints constraints) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sessions This Week',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...stats.sessionMetrics.map(
              (metric) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('EEEE').format(metric.date),
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      '${metric.sessionCount} sessions',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsChart(BuildContext context, BoxConstraints constraints) {
    final numberFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    if (stats.earningMetrics.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Earnings This Week',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text('No earnings data available for this week'),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Earnings This Week',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...stats.earningMetrics.map(
              (metric) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('EEEE').format(metric.date),
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      numberFormat.format(metric.amount),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total for Week:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  numberFormat.format(
                    stats.earningMetrics.fold<double>(
                      0,
                      (sum, metric) => sum + metric.amount,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 160;

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: isSmall ? 22 : 24,
                  color: Theme.of(context).primaryColor,
                  semanticLabel: '$title icon',
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: isSmall ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontSize: isSmall ? 9 : 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
