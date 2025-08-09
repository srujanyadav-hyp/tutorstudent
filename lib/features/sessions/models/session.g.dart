// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      id: json['id'] as String,
      tutorId: json['tutorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      videoLink: json['videoLink'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: $enumDecodeNullable(_$SessionStatusEnumMap, json['status']) ??
          SessionStatus.scheduled,
      studentIds: (json['studentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      attendance: (json['attendance'] as List<dynamic>?)
          ?.map((e) => SessionAttendance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'title': instance.title,
      'description': instance.description,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'videoLink': instance.videoLink,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$SessionStatusEnumMap[instance.status]!,
      'studentIds': instance.studentIds,
      'attendance': instance.attendance,
    };

const _$SessionStatusEnumMap = {
  SessionStatus.scheduled: 'scheduled',
  SessionStatus.inProgress: 'in_progress',
  SessionStatus.completed: 'completed',
  SessionStatus.cancelled: 'cancelled',
};

_$SessionAttendanceImpl _$$SessionAttendanceImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionAttendanceImpl(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      studentId: json['studentId'] as String,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$$SessionAttendanceImplToJson(
        _$SessionAttendanceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'studentId': instance.studentId,
      'joinedAt': instance.joinedAt.toIso8601String(),
    };
