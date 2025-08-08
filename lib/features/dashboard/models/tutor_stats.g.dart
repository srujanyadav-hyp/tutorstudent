// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TutorStatsImpl _$$TutorStatsImplFromJson(Map<String, dynamic> json) =>
    _$TutorStatsImpl(
      totalSessions: (json['totalSessions'] as num).toInt(),
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      upcomingSessions: (json['upcomingSessions'] as num).toInt(),
      activeStudents: (json['activeStudents'] as num).toInt(),
      sessionMetrics: (json['sessionMetrics'] as List<dynamic>)
          .map((e) => SessionMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
      earningMetrics: (json['earningMetrics'] as List<dynamic>)
          .map((e) => EarningMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TutorStatsImplToJson(_$TutorStatsImpl instance) =>
    <String, dynamic>{
      'totalSessions': instance.totalSessions,
      'totalEarnings': instance.totalEarnings,
      'upcomingSessions': instance.upcomingSessions,
      'activeStudents': instance.activeStudents,
      'sessionMetrics': instance.sessionMetrics,
      'earningMetrics': instance.earningMetrics,
    };

_$SessionMetricImpl _$$SessionMetricImplFromJson(Map<String, dynamic> json) =>
    _$SessionMetricImpl(
      date: DateTime.parse(json['date'] as String),
      sessionCount: (json['sessionCount'] as num).toInt(),
    );

Map<String, dynamic> _$$SessionMetricImplToJson(_$SessionMetricImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'sessionCount': instance.sessionCount,
    };

_$EarningMetricImpl _$$EarningMetricImplFromJson(Map<String, dynamic> json) =>
    _$EarningMetricImpl(
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$EarningMetricImplToJson(_$EarningMetricImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
    };
