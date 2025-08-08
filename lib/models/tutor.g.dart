// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tutor _$TutorFromJson(Map<String, dynamic> json) => Tutor(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      userId: json['user_id'] as String,
      expertise: json['expertise'] as String?,
      qualifications: json['qualifications'] as String?,
      experienceYears: (json['experience_years'] as num?)?.toInt(),
      pricing: (json['pricing'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TutorToJson(Tutor instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'user_id': instance.userId,
      'expertise': instance.expertise,
      'qualifications': instance.qualifications,
      'experience_years': instance.experienceYears,
      'pricing': instance.pricing,
    };
