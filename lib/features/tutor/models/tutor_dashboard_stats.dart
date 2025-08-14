import 'package:freezed_annotation/freezed_annotation.dart';

part 'tutor_dashboard_stats.freezed.dart';
part 'tutor_dashboard_stats.g.dart';

@freezed
class TutorDashboardStats with _$TutorDashboardStats {
  const factory TutorDashboardStats({
    @Default(0) int totalSessions,
    @Default(0) int activeStudents,
    @Default(0.0) double totalEarnings,
    @Default(0.0) double averageRating,
    @Default([]) List<double> performanceTrend,
    @Default(0) int completedSessions,
    @Default(0) int pendingSessions,
    @Default(0) int totalStudents,
  }) = _TutorDashboardStats;

  factory TutorDashboardStats.fromJson(Map<String, dynamic> json) =>
      _$TutorDashboardStatsFromJson(json);
}
