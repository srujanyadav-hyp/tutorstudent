// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as String,
      tutorId: json['tutorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      videoLink: json['videoLink'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      attendance: (json['attendance'] as List<dynamic>?)
          ?.map((e) => SessionAttendance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'title': instance.title,
      'description': instance.description,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'videoLink': instance.videoLink,
      'createdAt': instance.createdAt.toIso8601String(),
      'attendance': instance.attendance,
    };

SessionAttendance _$SessionAttendanceFromJson(Map<String, dynamic> json) =>
    SessionAttendance(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      studentId: json['studentId'] as String,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$SessionAttendanceToJson(SessionAttendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'studentId': instance.studentId,
      'joinedAt': instance.joinedAt.toIso8601String(),
    };
