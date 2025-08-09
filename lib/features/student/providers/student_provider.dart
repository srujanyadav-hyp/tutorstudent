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
