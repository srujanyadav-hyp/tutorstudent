import 'package:fl_chart/fl_chart.dart';
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatCards(context),
          const SizedBox(height: 24),
          _buildSessionChart(context),
          const SizedBox(height: 24),
          _buildEarningsChart(context),
        ],
      ),
    );
  }

  Widget _buildStatCards(BuildContext context) {
    final numberFormat = NumberFormat.currency(symbol: '\$');
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width < 600 ? 2 : 3;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: width < 600 ? 1.5 : 1.3,
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

  Widget _buildSessionChart(BuildContext context) {
    if (stats.sessionMetrics.isEmpty) {
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
              const Center(
                child: Text('No session data available for this week'),
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
              'Sessions This Week',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY:
                      (stats.sessionMetrics
                                  .map((m) => m.sessionCount.toDouble())
                                  .reduce((a, b) => a > b ? a : b) *
                              1.2)
                          .clamp(5.0, double.infinity),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < stats.sessionMetrics.length) {
                            try {
                              return Text(
                                DateFormat('E').format(
                                  stats.sessionMetrics[value.toInt()].date,
                                ),
                                semanticsLabel: DateFormat('EEEE').format(
                                  stats.sessionMetrics[value.toInt()].date,
                                ),
                              );
                            } catch (e) {
                              return const SizedBox();
                            }
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: stats.sessionMetrics
                      .asMap()
                      .entries
                      .map(
                        (entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.sessionCount.toDouble(),
                              width: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsChart(BuildContext context) {
    final numberFormat = NumberFormat.currency(symbol: '\$');

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

    // Calculate maxY safely
    final maxAmount = stats.earningMetrics
        .map((m) => m.amount)
        .reduce((a, b) => a > b ? a : b);
    final maxY = maxAmount > 0 ? maxAmount * 1.2 : 100.0;

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
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: maxY,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          try {
                            return Text(
                              numberFormat.format(value),
                              semanticsLabel:
                                  '${numberFormat.format(value)} dollars',
                            );
                          } catch (e) {
                            return const SizedBox();
                          }
                        },
                        reservedSize: 60,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < stats.earningMetrics.length) {
                            try {
                              return Text(
                                DateFormat('E').format(
                                  stats.earningMetrics[value.toInt()].date,
                                ),
                                semanticsLabel: DateFormat('EEEE').format(
                                  stats.earningMetrics[value.toInt()].date,
                                ),
                              );
                            } catch (e) {
                              return const SizedBox();
                            }
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: stats.earningMetrics
                          .asMap()
                          .entries
                          .map(
                            (entry) => FlSpot(
                              entry.key.toDouble(),
                              entry.value.amount,
                            ),
                          )
                          .toList(),
                      isCurved: true,
                      color: Theme.of(context).primaryColor,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.1),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).primaryColor,
              semanticLabel: '$title icon',
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ) ??
                  TextStyle(
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                  ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
