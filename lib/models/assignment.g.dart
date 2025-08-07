// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assignment _$AssignmentFromJson(Map<String, dynamic> json) => Assignment(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      tutorId: json['tutorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      subject: json['subject'] as String?,
    );

Map<String, dynamic> _$AssignmentToJson(Assignment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'tutorId': instance.tutorId,
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate?.toIso8601String(),
      'subject': instance.subject,
    };
