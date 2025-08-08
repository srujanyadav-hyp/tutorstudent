// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      userId: json['user_id'] as String,
      tutorId: json['tutor_id'] as String,
      parentId: json['parent_id'] as String?,
      grade: json['grade'] as String?,
      subjects: json['subjects'] as String?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'user_id': instance.userId,
      'tutor_id': instance.tutorId,
      'parent_id': instance.parentId,
      'grade': instance.grade,
      'subjects': instance.subjects,
    };
