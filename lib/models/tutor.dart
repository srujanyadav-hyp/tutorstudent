import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'tutor.g.dart';

@JsonSerializable()
class Tutor extends BaseModel {
  final String userId;
  final String? expertise;
  final String? qualifications;
  final int? experienceYears;
  final double? pricing;

  Tutor({
    super.id,
    super.createdAt,
    required this.userId,
    this.expertise,
    this.qualifications,
    this.experienceYears,
    this.pricing,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TutorToJson(this);

  @override
  Map<String, dynamic> toMap() => {
    'user_id': userId,
    'expertise': expertise,
    'qualifications': qualifications,
    'experience_years': experienceYears,
    'pricing': pricing,
    'created_at': createdAt.toIso8601String(),
  };
}
