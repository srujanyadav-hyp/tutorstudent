import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'tutor.g.dart';

@JsonSerializable()
class Tutor extends BaseModel {
  @JsonKey(name: 'user_id')
  final String userId;
  final String? expertise;
  final String? qualifications;
  @JsonKey(name: 'experience_years')
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
}
