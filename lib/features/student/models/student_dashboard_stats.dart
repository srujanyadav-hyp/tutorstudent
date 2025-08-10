import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_dashboard_stats.freezed.dart';
part 'student_dashboard_stats.g.dart';

@freezed
class StudentDashboardStats with _$StudentDashboardStats {
  const factory StudentDashboardStats({
    required int totalSessions,
    required int upcomingSessions,
    required int completedAssignments,
    required int pendingAssignments,
    required double averageScore,
    required Map<String, double> subjectPerformance,
    required List<DateTime> sessionDates,
    required List<double> progressTrend,
  }) = _StudentDashboardStats;

  factory StudentDashboardStats.fromJson(Map<String, dynamic> json) =>
      _$StudentDashboardStatsFromJson(json);

  factory StudentDashboardStats.empty() => const StudentDashboardStats(
    totalSessions: 0,
    upcomingSessions: 0,
    completedAssignments: 0,
    pendingAssignments: 0,
    averageScore: 0,
    subjectPerformance: {},
    sessionDates: [],
    progressTrend: [],
  );
}
