// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_dashboard_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParentDashboardStatsImpl _$$ParentDashboardStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$ParentDashboardStatsImpl(
      totalStudents: (json['totalStudents'] as num).toInt(),
      upcomingSessions: (json['upcomingSessions'] as num).toInt(),
      totalSpent: (json['totalSpent'] as num).toDouble(),
      pendingPayments: (json['pendingPayments'] as num).toInt(),
      recentActivities: (json['recentActivities'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$ParentDashboardStatsImplToJson(
        _$ParentDashboardStatsImpl instance) =>
    <String, dynamic>{
      'totalStudents': instance.totalStudents,
      'upcomingSessions': instance.upcomingSessions,
      'totalSpent': instance.totalSpent,
      'pendingPayments': instance.pendingPayments,
      'recentActivities': instance.recentActivities,
    };
