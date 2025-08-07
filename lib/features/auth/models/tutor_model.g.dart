// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TutorModelImpl _$$TutorModelImplFromJson(Map<String, dynamic> json) =>
    _$TutorModelImpl(
      userId: json['user_id'] as String,
      expertise: json['expertise'] as String?,
      qualifications: json['qualifications'] as String?,
      experienceYears: (json['experience_years'] as num?)?.toInt(),
      pricing: (json['pricing'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TutorModelImplToJson(_$TutorModelImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'expertise': instance.expertise,
      'qualifications': instance.qualifications,
      'experience_years': instance.experienceYears,
      'pricing': instance.pricing,
      'created_at': instance.createdAt.toIso8601String(),
    };
