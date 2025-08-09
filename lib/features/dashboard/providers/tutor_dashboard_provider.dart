import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tutor/models/tutor_stats.dart';
import '../../../core/services/tutor_service.dart';

class TutorDashboardProvider extends StateNotifier<AsyncValue<TutorStats>> {
  final String tutorId;
  final TutorService _tutorService;

  TutorDashboardProvider(this.tutorId, {TutorService? tutorService})
    : _tutorService = tutorService ?? TutorService(),
      super(const AsyncValue.loading()) {
    _fetchStats();
  }

  Future<void> _fetchStats() async {
    try {
      state = const AsyncValue.loading();
      final stats = await _tutorService.getTutorStats(tutorId);
      state = AsyncValue.data(stats);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await _fetchStats();
  }
}

final tutorDashboardProvider =
    StateNotifierProvider.family<
      TutorDashboardProvider,
      AsyncValue<TutorStats>,
      String
    >((ref, tutorId) => TutorDashboardProvider(tutorId));
