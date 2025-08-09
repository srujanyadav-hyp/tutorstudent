import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/parent_dashboard_provider.dart';
import '../widgets/activity_timeline.dart';
import '../widgets/stats_grid.dart';
import '../widgets/student_card.dart';
import '../widgets/link_student_dialog.dart';
import '../widgets/error_display.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/widgets/login_redirect.dart';

class ParentDashboard extends ConsumerWidget {
  const ParentDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parentId = ref.watch(currentUserProvider)?.id;
    if (parentId == null) return const LoginRedirect();

    final statsAsync = ref.watch(parentDashboardStatsProvider(parentId));
    final studentsAsync = ref.watch(linkedStudentsProvider(parentId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _showLinkStudentDialog(context, parentId),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          ref.invalidate(parentDashboardStatsProvider(parentId));
          ref.invalidate(linkedStudentsProvider(parentId));
          return Future.delayed(const Duration(milliseconds: 100));
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              statsAsync.when(
                data: (stats) => StatsGrid(stats: stats),
                loading: () => const StatsGridPlaceholder(),
                error: (error, stack) => ErrorDisplay(error: error),
              ),
              const SizedBox(height: 24),
              const Text(
                'Linked Students',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              studentsAsync.when(
                data: (students) => students.isEmpty
                    ? const EmptyStudentsList()
                    : LinkedStudentsList(students: students),
                loading: () => const StudentsListPlaceholder(),
                error: (error, stack) => ErrorDisplay(error: error),
              ),
              const SizedBox(height: 24),
              const Text(
                'Recent Activity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              statsAsync.when(
                data: (stats) =>
                    ActivityTimeline(activities: stats.recentActivities),
                loading: () => const ActivityTimelinePlaceholder(),
                error: (error, stack) => ErrorDisplay(error: error),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLinkStudentDialog(BuildContext context, String parentId) {
    return showDialog(
      context: context,
      builder: (context) => LinkStudentDialog(parentId: parentId),
    );
  }
}
