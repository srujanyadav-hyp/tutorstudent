// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_dashboard_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TutorDashboardStatsImpl _$$TutorDashboardStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$TutorDashboardStatsImpl(
      totalSessions: (json['totalSessions'] as num?)?.toInt() ?? 0,
      activeStudents: (json['activeStudents'] as num?)?.toInt() ?? 0,
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      performanceTrend: (json['performanceTrend'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      completedSessions: (json['completedSessions'] as num?)?.toInt() ?? 0,
      pendingSessions: (json['pendingSessions'] as num?)?.toInt() ?? 0,
      totalStudents: (json['totalStudents'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TutorDashboardStatsImplToJson(
        _$TutorDashboardStatsImpl instance) =>
    <String, dynamic>{
      'totalSessions': instance.totalSessions,
      'activeStudents': instance.activeStudents,
      'totalEarnings': instance.totalEarnings,
      'averageRating': instance.averageRating,
      'performanceTrend': instance.performanceTrend,
      'completedSessions': instance.completedSessions,
      'pendingSessions': instance.pendingSessions,
      'totalStudents': instance.totalStudents,
    };
