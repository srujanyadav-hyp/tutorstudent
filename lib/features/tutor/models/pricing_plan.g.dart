// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PricingPlanImpl _$$PricingPlanImplFromJson(Map<String, dynamic> json) =>
    _$PricingPlanImpl(
      id: json['id'] as String,
      tutorId: json['tutorId'] as String,
      monthlyRate: (json['monthlyRate'] as num).toDouble(),
      description: json['description'] as String?,
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PricingPlanImplToJson(_$PricingPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'monthlyRate': instance.monthlyRate,
      'description': instance.description,
      'features': instance.features,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
