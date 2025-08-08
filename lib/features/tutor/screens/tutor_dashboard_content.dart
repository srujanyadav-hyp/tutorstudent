import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../sessions/providers/session_provider.dart';
import '../../../core/services/supabase_service.dart';
import 'package:intl/intl.dart';

class TutorDashboardContent extends ConsumerWidget {
  const TutorDashboardContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = SupabaseService().client.auth.currentUser?.id;
    if (userId == null) return const SizedBox();

    final upcomingSessions = ref.watch(upcomingSessionsProvider(userId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh logic if needed
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _DashboardCard(
                    title: 'Today\'s Sessions',
                    value: upcomingSessions
                        .where((s) =>
                            s.scheduledAt.year == DateTime.now().year &&
                            s.scheduledAt.day == DateTime.now().day)
                        .length
                        .toString(),
                    icon: Icons.today,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _DashboardCard(
                    title: 'Active Students',
                    value: '0', // TODO: Implement student count
                    icon: Icons.people,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Upcoming Sessions
            Text(
              'Upcoming Sessions',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (upcomingSessions.isEmpty)
              const Center(
                child: Text('No upcoming sessions'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    upcomingSessions.length > 3 ? 3 : upcomingSessions.length,
                itemBuilder: (context, index) {
                  final session = upcomingSessions[index];
                  return _SessionListTile(
                    title: session.title,
                    dateTime: session.scheduledAt,
                    status: session.status,
                  );
                },
              ),

            const SizedBox(height: 24),

            // Quick Actions
            Text(
              'Quick Actions',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _ActionButton(
                  icon: Icons.add_circle,
                  label: 'New Session',
                  onTap: () {
                    // TODO: Navigate to create session
                  },
                ),
                _ActionButton(
                  icon: Icons.person_add,
                  label: 'Add Student',
                  onTap: () {
                    // TODO: Navigate to add student
                  },
                ),
                _ActionButton(
                  icon: Icons.calendar_today,
                  label: 'Schedule',
                  onTap: () {
                    // TODO: Navigate to schedule
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _SessionListTile extends StatelessWidget {
  final String title;
  final DateTime dateTime;
  final String status;

  const _SessionListTile({
    required this.title,
    required this.dateTime,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, hh:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(dateFormat.format(dateTime)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status.toUpperCase(),
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
