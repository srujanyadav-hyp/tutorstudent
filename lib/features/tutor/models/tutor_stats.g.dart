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
      totalStudents: (json['totalStudents'] as num).toInt(),
      monthlyEarnings: (json['monthlyEarnings'] as num).toDouble(),
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReviews: (json['totalReviews'] as num).toInt(),
      sessionsPerDay: Map<String, int>.from(json['sessionsPerDay'] as Map),
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
      'totalStudents': instance.totalStudents,
      'monthlyEarnings': instance.monthlyEarnings,
      'averageRating': instance.averageRating,
      'totalReviews': instance.totalReviews,
      'sessionsPerDay': instance.sessionsPerDay,
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
