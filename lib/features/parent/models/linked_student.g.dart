// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linked_student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LinkedStudentImpl _$$LinkedStudentImplFromJson(Map<String, dynamic> json) =>
    _$LinkedStudentImpl(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      grade: json['grade'] as String?,
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$$LinkedStudentImplToJson(_$LinkedStudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'grade': instance.grade,
      'profileImage': instance.profileImage,
    };
