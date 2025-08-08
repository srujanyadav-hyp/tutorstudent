import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tutor_stats.dart';
import '../services/tutor_dashboard_service.dart';

final tutorDashboardServiceProvider =
    Provider((ref) => TutorDashboardService());

final tutorStatsProvider =
    FutureProvider.family<TutorStats, String>((ref, tutorId) async {
  final service = ref.watch(tutorDashboardServiceProvider);
  return await service.getTutorStats(tutorId);
});

final tutorEarningsProvider =
    StreamProvider.family<double, String>((ref, tutorId) {
  final service = ref.watch(tutorDashboardServiceProvider);
  return service.streamTutorEarnings(tutorId);
});

final upcomingSessionsCountProvider =
    StreamProvider.family<int, String>((ref, tutorId) {
  final service = ref.watch(tutorDashboardServiceProvider);
  return service.streamUpcomingSessionsCount(tutorId);
});

final activeStudentsProvider =
    StreamProvider.family<List<String>, String>((ref, tutorId) {
  final service = ref.watch(tutorDashboardServiceProvider);
  return service.streamActiveStudents(tutorId);
});
