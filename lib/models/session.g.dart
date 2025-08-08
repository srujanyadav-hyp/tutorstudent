// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      tutorId: json['tutorId'] as String,
      studentId: json['studentId'] as String,
      title: json['title'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      duration: (json['duration'] as num).toInt(),
      meetingLink: json['meetingLink'] as String?,
      status: $enumDecodeNullable(_$SessionStatusEnumMap, json['status']) ??
          SessionStatus.upcoming,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'tutorId': instance.tutorId,
      'studentId': instance.studentId,
      'title': instance.title,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'duration': instance.duration,
      'meetingLink': instance.meetingLink,
      'status': _$SessionStatusEnumMap[instance.status]!,
    };

const _$SessionStatusEnumMap = {
  SessionStatus.upcoming: 'upcoming',
  SessionStatus.completed: 'completed',
  SessionStatus.cancelled: 'cancelled',
};
