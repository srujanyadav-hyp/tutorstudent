// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      userId: json['userId'] as String,
      tutorId: json['tutorId'] as String,
      parentId: json['parentId'] as String?,
      grade: json['grade'] as String?,
      subjects: json['subjects'] as String?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'userId': instance.userId,
      'tutorId': instance.tutorId,
      'parentId': instance.parentId,
      'grade': instance.grade,
      'subjects': instance.subjects,
    };
