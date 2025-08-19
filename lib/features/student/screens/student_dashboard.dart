import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';
import '../widgets/student_scaffold.dart';
import '../widgets/error_view.dart';
import 'package:go_router/go_router.dart';

class StudentDashboard extends ConsumerWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return Scaffold(
        body: ErrorView(
          message: 'You need to be signed in to access the dashboard.',
          onRetry: () => ref.refresh(supabaseServiceProvider),
        ),
      );
    }

    final statsAsync = ref.watch(studentStatsProvider(user.id));
    final upcomingSessions = ref.watch(upcomingSessionsProvider(user.id));
    final assignments = ref.watch(assignmentsProvider(user.id));

    return StudentScaffold(
      title: 'Dashboard',
      currentIndex: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle),
          tooltip: 'Profile',
          onPressed: () {
            GoRouter.of(context).go('/student/profile');
          },
        ),
      ],
      body: statsAsync.when(
        data: (stats) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(),
              const SizedBox(height: 20),
              _buildQuickStats(stats),
              const SizedBox(height: 20),
              _buildUpcomingSessions(context, upcomingSessions),
              const SizedBox(height: 20),
              _buildRecentAssignments(context, assignments),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(studentStatsProvider(user.id)),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ready to learn something new today?',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(dynamic stats) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Sessions',
            stats?.totalSessions?.toString() ?? '0',
            Icons.calendar_today,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Assignments',
            stats?.completedAssignments?.toString() ?? '0',
            Icons.assignment,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Score',
            '${((stats?.averageScore ?? 0) * 100).round()}%',
            Icons.score,
            Colors.orange,
          ),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
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
        const Text(
          'Upcoming Sessions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        sessionsAsync.when(
          data: (sessions) {
            if (sessions.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'No upcoming sessions',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: sessions
                  .take(3)
                  .map((session) => _buildSessionCard(session))
                  .toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Error: $error'),
        ),
      ],
    );
  }

  Widget _buildSessionCard(Map<String, dynamic> session) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.calendar_today, color: Colors.white),
        ),
        title: Text(session['title'] ?? 'Session'),
        subtitle: Text(session['scheduled_at'] ?? ''),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _buildRecentAssignments(
    BuildContext context,
    AsyncValue<List<Map<String, dynamic>>> assignmentsAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Assignments',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        assignmentsAsync.when(
          data: (assignments) {
            if (assignments.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'No assignments',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: assignments
                  .take(3)
                  .map((assignment) => _buildAssignmentCard(assignment))
                  .toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Error: $error'),
        ),
      ],
    );
  }

  Widget _buildAssignmentCard(Map<String, dynamic> assignment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.assignment, color: Colors.white),
        ),
        title: Text(assignment['title'] ?? 'Assignment'),
        subtitle: Text(assignment['due_date'] ?? ''),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
