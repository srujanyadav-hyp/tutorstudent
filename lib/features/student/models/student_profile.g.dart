// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentProfileImpl _$$StudentProfileImplFromJson(Map<String, dynamic> json) =>
    _$StudentProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      grade: json['grade'] as String?,
      subjects:
          (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
      parentId: json['parent_id'] as String?,
      tutorIds:
          (json['tutor_ids'] as List<dynamic>).map((e) => e as String).toList(),
      subjectProgress: (json['subject_progress'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$StudentProfileImplToJson(
        _$StudentProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'grade': instance.grade,
      'subjects': instance.subjects,
      'parent_id': instance.parentId,
      'tutor_ids': instance.tutorIds,
      'subject_progress': instance.subjectProgress,
      'created_at': instance.createdAt.toIso8601String(),
    };
