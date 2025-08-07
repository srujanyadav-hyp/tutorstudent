// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tutor _$TutorFromJson(Map<String, dynamic> json) => Tutor(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      userId: json['userId'] as String,
      expertise: json['expertise'] as String?,
      qualifications: json['qualifications'] as String?,
      experienceYears: (json['experienceYears'] as num?)?.toInt(),
      pricing: (json['pricing'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TutorToJson(Tutor instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'userId': instance.userId,
      'expertise': instance.expertise,
      'qualifications': instance.qualifications,
      'experienceYears': instance.experienceYears,
      'pricing': instance.pricing,
    };
