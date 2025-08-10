// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_dashboard_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentDashboardStatsImpl _$$StudentDashboardStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$StudentDashboardStatsImpl(
      totalSessions: (json['totalSessions'] as num).toInt(),
      upcomingSessions: (json['upcomingSessions'] as num).toInt(),
      completedAssignments: (json['completedAssignments'] as num).toInt(),
      pendingAssignments: (json['pendingAssignments'] as num).toInt(),
      averageScore: (json['averageScore'] as num).toDouble(),
      subjectPerformance:
          (json['subjectPerformance'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      sessionDates: (json['sessionDates'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      progressTrend: (json['progressTrend'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$$StudentDashboardStatsImplToJson(
        _$StudentDashboardStatsImpl instance) =>
    <String, dynamic>{
      'totalSessions': instance.totalSessions,
      'upcomingSessions': instance.upcomingSessions,
      'completedAssignments': instance.completedAssignments,
      'pendingAssignments': instance.pendingAssignments,
      'averageScore': instance.averageScore,
      'subjectPerformance': instance.subjectPerformance,
      'sessionDates':
          instance.sessionDates.map((e) => e.toIso8601String()).toList(),
      'progressTrend': instance.progressTrend,
    };
