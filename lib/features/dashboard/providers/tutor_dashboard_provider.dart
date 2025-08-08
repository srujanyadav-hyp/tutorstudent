import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tutor_stats.dart';
import '../services/tutor_dashboard_service.dart';

final tutorStatsProvider =
    FutureProvider.family<TutorStats, String>((ref, tutorId) async {
  final dashboardService = ref.watch(tutorDashboardServiceProvider);
  return dashboardService.getTutorStats(tutorId);
});
