// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      id: json['id'] as String,
      tutorId: json['tutor_id'] as String,
      studentId: json['student_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      scheduledAt: _fromJsonRequired(json['scheduled_at'] as String),
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String? ?? 'pending',
      paymentStatus: json['payment_status'] as String? ?? 'pending',
      completedAt: _fromJsonNullable(json['completed_at'] as String?),
      meetingUrl: json['meeting_url'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutor_id': instance.tutorId,
      'student_id': instance.studentId,
      'title': instance.title,
      'description': instance.description,
      'scheduled_at': _toJsonRequired(instance.scheduledAt),
      'amount': instance.amount,
      'status': instance.status,
      'payment_status': instance.paymentStatus,
      'completed_at': _toJsonNullable(instance.completedAt),
      'meeting_url': instance.meetingUrl,
      'notes': instance.notes,
    };
