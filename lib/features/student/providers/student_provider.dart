import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student_dashboard_stats.dart';
import '../models/student_profile.dart';
import '../services/student_service.dart';

final studentProfileProvider = FutureProvider.family<StudentProfile, String>((
  ref,
  studentId,
) async {
  final service = ref.watch(studentServiceProvider);
  return service.getStudentProfile(studentId);
});

final studentStatsProvider =
    FutureProvider.family<StudentDashboardStats, String>((
      ref,
      studentId,
    ) async {
      final service = ref.watch(studentServiceProvider);
      return service.getStudentStats(studentId);
    });

final availableTutorsProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final service = ref.watch(studentServiceProvider);
  return service.getAvailableTutors();
});

final upcomingSessionsProvider =
    StreamProvider.family<List<Map<String, dynamic>>, String>((ref, studentId) {
      final service = ref.watch(studentServiceProvider);
      return service.streamUpcomingSessions(studentId);
    });

final assignmentsProvider =
    StreamProvider.family<List<Map<String, dynamic>>, String>((ref, studentId) {
      final service = ref.watch(studentServiceProvider);
      return service.streamAssignments(studentId);
    });

final assignmentProvider = FutureProvider.family<Map<String, dynamic>, String>((
  ref,
  assignmentId,
) async {
  final service = ref.watch(studentServiceProvider);
  return service.getAssignmentDetails(assignmentId);
});

final sessionProvider = FutureProvider.family<Map<String, dynamic>, String>((
  ref,
  sessionId,
) async {
  final service = ref.watch(studentServiceProvider);
  return service.getSessionDetails(sessionId);
});

final studentNotifierProvider =
    StateNotifierProvider.family<StudentNotifier, AsyncValue<void>, String>(
      (ref, studentId) => StudentNotifier(ref, studentId),
    );

class StudentNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;
  final String _studentId;

  StudentNotifier(this._ref, this._studentId)
    : super(const AsyncValue.data(null));

  Future<void> connectWithTutor(String tutorId) async {
    state = const AsyncValue.loading();
    try {
      final service = _ref.read(studentServiceProvider);
      await service.connectWithTutor(_studentId, tutorId);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> submitSessionFeedback(
    String sessionId,
    double rating,
    String feedback,
  ) async {
    state = const AsyncValue.loading();
    try {
      final service = _ref.read(studentServiceProvider);
      await service.submitSessionFeedback(
        sessionId,
        _studentId,
        rating,
        feedback,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> submitAssignment(
    String assignmentId,
    String comment,
    File file,
  ) async {
    state = const AsyncValue.loading();
    try {
      final service = _ref.read(studentServiceProvider);
      await service.submitAssignment(assignmentId, _studentId, comment, file);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Filtering state and derived providers

enum SessionFilter { all, upcoming, live }

final sessionFilterProvider = StateProvider<SessionFilter>(
  (ref) => SessionFilter.all,
);

final upcomingSessionsFilteredProvider =
    Provider.family<AsyncValue<List<Map<String, dynamic>>>, String>((
      ref,
      studentId,
    ) {
      final filter = ref.watch(sessionFilterProvider);
      final sessionsAsync = ref.watch(upcomingSessionsProvider(studentId));
      return sessionsAsync.whenData((sessions) {
        final now = DateTime.now();
        return sessions.where((s) {
          try {
            final when = DateTime.parse(s['scheduled_at'] as String);
            final isLive =
                when.isBefore(now) &&
                when.add(const Duration(hours: 1)).isAfter(now);
            final isUpcoming = when.isAfter(now);
            switch (filter) {
              case SessionFilter.all:
                return true;
              case SessionFilter.upcoming:
                return isUpcoming;
              case SessionFilter.live:
                return isLive;
            }
          } catch (_) {
            return true;
          }
        }).toList();
      });
    });

enum AssignmentFilter { all, pending, submitted }

final assignmentFilterProvider = StateProvider<AssignmentFilter>(
  (ref) => AssignmentFilter.all,
);

final assignmentsFilteredProvider =
    Provider.family<AsyncValue<List<Map<String, dynamic>>>, String>((
      ref,
      studentId,
    ) {
      final filter = ref.watch(assignmentFilterProvider);
      final assignmentsAsync = ref.watch(assignmentsProvider(studentId));
      return assignmentsAsync.whenData((assignments) {
        return assignments.where((a) {
          final submittedAt = a['submitted_at'];
          switch (filter) {
            case AssignmentFilter.all:
              return true;
            case AssignmentFilter.pending:
              return submittedAt == null;
            case AssignmentFilter.submitted:
              return submittedAt != null;
          }
        }).toList();
      });
    });

final tutorSearchQueryProvider = StateProvider<String>((ref) => '');

final availableTutorsFilteredProvider =
    Provider<AsyncValue<List<Map<String, dynamic>>>>((ref) {
      final query = ref.watch(tutorSearchQueryProvider).trim().toLowerCase();
      final tutorsAsync = ref.watch(availableTutorsProvider);
      return tutorsAsync.whenData((tutors) {
        if (query.isEmpty) return tutors;
        return tutors.where((t) {
          final name = (t['full_name'] ?? '').toString().toLowerCase();
          final bio = (t['bio'] ?? '').toString().toLowerCase();
          return name.contains(query) || bio.contains(query);
        }).toList();
      });
    });
