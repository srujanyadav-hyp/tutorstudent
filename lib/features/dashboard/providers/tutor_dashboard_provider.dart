import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tutor/models/tutor_stats.dart';
import '../../tutor/services/tutor_dashboard_service_new.dart' as tutor_service;

final tutorStatsProvider = FutureProvider.family<TutorStats, String>((
  ref,
  tutorId,
) async {
  final dashboardService = ref.watch(
    tutor_service.tutorDashboardServiceProvider,
  );
  return dashboardService.getTutorStats(tutorId);
});
