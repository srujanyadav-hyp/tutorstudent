import 'package:freezed_annotation/freezed_annotation.dart';

part 'parent_dashboard_stats.freezed.dart';
part 'parent_dashboard_stats.g.dart';

@freezed
class ParentDashboardStats with _$ParentDashboardStats {
  const factory ParentDashboardStats({
    required int totalStudents,
    required int upcomingSessions,
    required double totalSpent,
    required int pendingPayments,
    required List<Map<String, dynamic>> recentActivities,
  }) = _ParentDashboardStats;

  factory ParentDashboardStats.fromJson(Map<String, dynamic> json) =>
      _$ParentDashboardStatsFromJson(json);
}
