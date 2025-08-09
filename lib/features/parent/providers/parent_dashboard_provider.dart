import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/parent_dashboard_service.dart';
import '../models/parent_dashboard_stats.dart';

final parentDashboardServiceProvider = Provider(
  (ref) => ParentDashboardService(),
);

final parentDashboardStatsProvider =
    FutureProvider.family<ParentDashboardStats, String>((ref, parentId) async {
      return ref.read(parentDashboardServiceProvider).getParentStats(parentId);
    });

final linkedStudentsProvider =
    StreamProvider.family<List<Map<String, dynamic>>, String>((ref, parentId) {
      return ref
          .read(parentDashboardServiceProvider)
          .streamLinkedStudents(parentId);
    });
