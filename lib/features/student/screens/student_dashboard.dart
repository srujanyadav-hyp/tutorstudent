import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';
import '../widgets/session_card.dart';
import '../widgets/assignment_card.dart';
import '../widgets/student_scaffold.dart';
import '../models/student_dashboard_stats.dart';
import 'package:go_router/go_router.dart';

class StudentDashboard extends ConsumerWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final statsAsync = ref.watch(studentStatsProvider(user.id));
    final upcomingSessions = ref.watch(upcomingSessionsProvider(user.id));
    final assignments = ref.watch(assignmentsProvider(user.id));

    return StudentScaffold(
      title: 'Dashboard',
      currentIndex: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            GoRouter.of(context).go('/profile');
          },
        ),
      ],
      body: statsAsync.when(
        data: (stats) => RefreshIndicator(
          onRefresh: () => ref.refresh(studentStatsProvider(user.id).future),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatCards(stats),
                const SizedBox(height: 24),
                _buildProgressChart(stats),
                const SizedBox(height: 24),
                _buildUpcomingSessions(context, upcomingSessions),
                const SizedBox(height: 24),
                _buildAssignments(context, assignments),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildStatCards(StudentDashboardStats stats) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard(
          'Total Sessions',
          stats.totalSessions.toString(),
          Icons.calendar_today,
          Colors.blue,
        ),
        _buildStatCard(
          'Upcoming',
          stats.upcomingSessions.toString(),
          Icons.upcoming,
          Colors.orange,
        ),
        _buildStatCard(
          'Completed Assignments',
          stats.completedAssignments.toString(),
          Icons.assignment_turned_in,
          Colors.green,
        ),
        _buildStatCard(
          'Average Score',
          '${(stats.averageScore * 100).round()}%',
          Icons.score,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressChart(StudentDashboardStats stats) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progress Trend',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        stats.progressTrend.length,
                        (index) => FlSpot(
                          index.toDouble(),
                          stats.progressTrend[index],
                        ),
                      ),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.1),
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

  Widget _buildUpcomingSessions(
    BuildContext context,
    AsyncValue<List<Map<String, dynamic>>> sessionsAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Upcoming Sessions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => GoRouter.of(context).go('/student/sessions'),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        sessionsAsync.when(
          data: (sessions) {
            if (sessions.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No upcoming sessions'),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sessions.length > 3 ? 3 : sessions.length,
              itemBuilder: (context, index) =>
                  SessionCard(session: sessions[index]),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text('Error: $error'),
        ),
      ],
    );
  }

  Widget _buildAssignments(
    BuildContext context,
    AsyncValue<List<Map<String, dynamic>>> assignmentsAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Assignments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => GoRouter.of(context).go('/student/assignments'),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        assignmentsAsync.when(
          data: (assignments) {
            if (assignments.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No assignments'),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: assignments.length > 3 ? 3 : assignments.length,
              itemBuilder: (context, index) =>
                  AssignmentCard(assignment: assignments[index]),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text('Error: $error'),
        ),
      ],
    );
  }
}
