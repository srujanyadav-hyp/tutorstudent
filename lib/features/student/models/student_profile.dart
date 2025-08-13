import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_profile.freezed.dart';
part 'student_profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@freezed
class StudentProfile with _$StudentProfile {
  const factory StudentProfile({
    required String id,
    required String name,
    required String email,
    String? grade,
    required List<String> subjects,
    String? parentId,
    required List<String> tutorIds,
    required Map<String, double> subjectProgress,
    required DateTime createdAt,
  }) = _StudentProfile;

  factory StudentProfile.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileFromJson(json);
}
