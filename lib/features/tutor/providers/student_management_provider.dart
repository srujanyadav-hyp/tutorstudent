import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student_management.dart';
import '../services/student_management_service.dart';

final managedStudentsProvider =
    FutureProvider.family<List<ManagedStudent>, String>((ref, tutorId) async {
      final service = ref.watch(studentManagementServiceProvider);
      return service.getStudents(tutorId);
    });

final studentProgressProvider = FutureProvider.family<StudentProgress, String>((
  ref,
  studentId,
) async {
  final service = ref.watch(studentManagementServiceProvider);
  return service.getStudentProgress(studentId);
});

final studentManagementProvider =
    StateNotifierProvider.family<
      StudentManagementNotifier,
      AsyncValue<void>,
      String
    >((ref, tutorId) {
      return StudentManagementNotifier(ref, tutorId);
    });

class StudentManagementNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;
  final String _tutorId;

  StudentManagementNotifier(this._ref, this._tutorId)
    : super(const AsyncValue.data(null));

  Future<void> addStudent(String studentEmail) async {
    state = const AsyncValue.loading();
    try {
      final service = _ref.read(studentManagementServiceProvider);
      await service.addStudent(_tutorId, studentEmail);
      _ref.invalidate(managedStudentsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeStudent(String connectionId) async {
    state = const AsyncValue.loading();
    try {
      final service = _ref.read(studentManagementServiceProvider);
      await service.removeStudent(connectionId);
      _ref.invalidate(managedStudentsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateStudentDetails(
    String connectionId, {
    String? grade,
    String? subjects,
  }) async {
    state = const AsyncValue.loading();
    try {
      final service = _ref.read(studentManagementServiceProvider);
      await service.updateStudentDetails(
        connectionId,
        grade: grade,
        subjects: subjects,
      );
      _ref.invalidate(managedStudentsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
