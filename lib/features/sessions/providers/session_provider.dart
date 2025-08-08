import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tutor_session.dart';
import '../services/session_service.dart';

final sessionServiceProvider = Provider((ref) => SessionService());

final tutorSessionsProvider = StreamProvider.family<List<TutorSession>, String>(
  (ref, tutorId) {
    final sessionService = ref.watch(sessionServiceProvider);
    return sessionService.streamTutorSessions(tutorId);
  },
);

final upcomingSessionsProvider = Provider.family<List<TutorSession>, String>(
  (ref, tutorId) {
    final sessionsAsync = ref.watch(tutorSessionsProvider(tutorId));
    return sessionsAsync.when(
      data: (sessions) {
        final now = DateTime.now();
        return sessions
            .where((session) =>
                session.scheduledAt.isAfter(now) &&
                session.status != 'cancelled')
            .toList()
          ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
      },
      loading: () => [],
      error: (_, __) => [],
    );
  },
);

class SessionNotifier extends StateNotifier<AsyncValue<void>> {
  final SessionService _sessionService;
  final String tutorId;

  SessionNotifier(this._sessionService, this.tutorId)
      : super(const AsyncValue.data(null));

  Future<void> createSession({
    required String title,
    String? description,
    required DateTime scheduledAt,
    String? videoLink,
    List<String>? studentIds,
  }) async {
    try {
      state = const AsyncValue.loading();
      await _sessionService.createSession(
        tutorId: tutorId,
        title: title,
        description: description,
        scheduledAt: scheduledAt,
        videoLink: videoLink,
        studentIds: studentIds,
      );
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> updateSession(TutorSession session) async {
    try {
      state = const AsyncValue.loading();
      await _sessionService.updateSession(session);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> deleteSession(String sessionId) async {
    try {
      state = const AsyncValue.loading();
      await _sessionService.deleteSession(sessionId);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> updateSessionStatus(String sessionId, String status) async {
    try {
      state = const AsyncValue.loading();
      await _sessionService.updateSessionStatus(sessionId, status);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }
}

final sessionNotifierProvider =
    StateNotifierProvider.family<SessionNotifier, AsyncValue<void>, String>(
  (ref, tutorId) {
    final sessionService = ref.watch(sessionServiceProvider);
    return SessionNotifier(sessionService, tutorId);
  },
);
