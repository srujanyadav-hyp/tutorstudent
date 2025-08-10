import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_profile.freezed.dart';
part 'student_profile.g.dart';

@freezed
class StudentProfile with _$StudentProfile {
  const factory StudentProfile({
    required String id,
    required String name,
    required String email,
    String? grade,
    required List<String> subjects,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'tutor_ids') required List<String> tutorIds,
    @JsonKey(name: 'subject_progress')
    required Map<String, double> subjectProgress,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _StudentProfile;

  factory StudentProfile.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileFromJson(json);
}
