// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tutor_model.freezed.dart';
part 'tutor_model.g.dart';

@freezed
class TutorModel with _$TutorModel {
  const factory TutorModel({
    @JsonKey(name: 'user_id') required String userId,
    String? expertise,
    String? qualifications,
    @JsonKey(name: 'experience_years') int? experienceYears,
    double? pricing,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TutorModel;

  factory TutorModel.fromJson(Map<String, dynamic> json) =>
      _$TutorModelFromJson(json);
}
