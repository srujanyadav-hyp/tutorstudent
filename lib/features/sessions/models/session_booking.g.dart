// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionBookingImpl _$$SessionBookingImplFromJson(Map<String, dynamic> json) =>
    _$SessionBookingImpl(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      tutorId: json['tutorId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      topic: json['topic'] as String?,
      notes: json['notes'] as String?,
      status:
          $enumDecodeNullable(_$SessionBookingStatusEnumMap, json['status']) ??
              SessionBookingStatus.pending,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SessionBookingImplToJson(
        _$SessionBookingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'tutorId': instance.tutorId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'topic': instance.topic,
      'notes': instance.notes,
      'status': _$SessionBookingStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$SessionBookingStatusEnumMap = {
  SessionBookingStatus.pending: 'pending',
  SessionBookingStatus.confirmed: 'confirmed',
  SessionBookingStatus.cancelled: 'cancelled',
  SessionBookingStatus.completed: 'completed',
};
