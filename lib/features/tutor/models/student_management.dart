import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_management.freezed.dart';
part 'student_management.g.dart';

@freezed
class ManagedStudent with _$ManagedStudent {
  const factory ManagedStudent({
    required String id,
    required String userId,
    required String name,
    required String email,
    String? grade,
    String? subjects,
    @Default(false) bool isActive,
    DateTime? lastSessionDate,
    @Default(0) int completedSessions,
    @Default(0) int upcomingSessions,
    @Default(0.0) double averagePerformance,
  }) = _ManagedStudent;

  factory ManagedStudent.fromJson(Map<String, dynamic> json) =>
      _$ManagedStudentFromJson(json);
}

@freezed
class StudentProgress with _$StudentProgress {
  const factory StudentProgress({
    required String studentId,
    @Default([]) List<SessionAttendance> sessionHistory,
    @Default([]) List<AssignmentProgress> assignments,
    @Default({}) Map<String, double> subjectPerformance,
  }) = _StudentProgress;

  factory StudentProgress.fromJson(Map<String, dynamic> json) =>
      _$StudentProgressFromJson(json);
}

@freezed
class SessionAttendance with _$SessionAttendance {
  const factory SessionAttendance({
    required String sessionId,
    required DateTime date,
    required bool attended,
    String? notes,
  }) = _SessionAttendance;

  factory SessionAttendance.fromJson(Map<String, dynamic> json) =>
      _$SessionAttendanceFromJson(json);
}

@freezed
class AssignmentProgress with _$AssignmentProgress {
  const factory AssignmentProgress({
    required String assignmentId,
    required String title,
    required DateTime dueDate,
    @Default(false) bool completed,
    @Default(0.0) double score,
    String? feedback,
  }) = _AssignmentProgress;

  factory AssignmentProgress.fromJson(Map<String, dynamic> json) =>
      _$AssignmentProgressFromJson(json);
}
