// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      id: json['id'] as String,
      tutorId: json['tutor_id'] as String,
      studentId: json['student_id'] as String,
      title: json['title'] as String,
      scheduledAt: DateTime.parse(json['scheduled_at'] as String),
      duration: (json['duration'] as num).toInt(),
      meetingLink: json['meeting_link'] as String?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutor_id': instance.tutorId,
      'student_id': instance.studentId,
      'title': instance.title,
      'scheduled_at': instance.scheduledAt.toIso8601String(),
      'duration': instance.duration,
      'meeting_link': instance.meetingLink,
      'status': instance.status,
    };
