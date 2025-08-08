import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tutor/models/tutor_stats.dart';
import '../services/tutor_dashboard_service.dart';

// Provide an instance of TutorDashboardService
final tutorDashboardServiceProvider = Provider(
  (ref) => TutorDashboardService(),
);

// Provide tutor stats data with automatic refresh
final tutorStatsProvider = FutureProvider.family<TutorStats, String>((
  ref,
  tutorId,
) async {
  final service = ref.watch(tutorDashboardServiceProvider);
  return service.getTutorStats(tutorId);
});

// Create an AutoDisposeFutureProvider that refreshes every minute
final autoRefreshTutorStatsProvider = FutureProvider.autoDispose
    .family<TutorStats, String>((ref, tutorId) async {
      // Set up periodic refresh
      final service = ref.watch(tutorDashboardServiceProvider);
      final result = await service.getTutorStats(tutorId);

      // Set up timer for periodic refresh
      ref.onDispose(() {
        // Clean up when the provider is disposed
      });

      // Set up periodic refresh
      Future.delayed(const Duration(minutes: 1), () {
        ref.invalidateSelf();
      });

      return result;
    });
