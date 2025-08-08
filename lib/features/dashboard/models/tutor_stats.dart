import 'package:freezed_annotation/freezed_annotation.dart';

part 'tutor_stats.freezed.dart';
part 'tutor_stats.g.dart';

@freezed
class TutorStats with _$TutorStats {
  const factory TutorStats({
    required int totalSessions,
    required double totalEarnings,
    required int upcomingSessions,
    required int activeStudents,
    required List<SessionMetric> sessionMetrics,
    required List<EarningMetric> earningMetrics,
  }) = _TutorStats;

  factory TutorStats.fromJson(Map<String, dynamic> json) =>
      _$TutorStatsFromJson(json);
}

@freezed
class SessionMetric with _$SessionMetric {
  const factory SessionMetric({
    required DateTime date,
    required int sessionCount,
  }) = _SessionMetric;

  factory SessionMetric.fromJson(Map<String, dynamic> json) =>
      _$SessionMetricFromJson(json);
}

@freezed
class EarningMetric with _$EarningMetric {
  const factory EarningMetric({
    required DateTime date,
    required double amount,
  }) = _EarningMetric;

  factory EarningMetric.fromJson(Map<String, dynamic> json) =>
      _$EarningMetricFromJson(json);
}
