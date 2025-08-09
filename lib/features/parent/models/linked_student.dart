import 'package:freezed_annotation/freezed_annotation.dart';

part 'linked_student.freezed.dart';
part 'linked_student.g.dart';

@freezed
class LinkedStudent with _$LinkedStudent {
  const factory LinkedStudent({
    required String id,
    required String fullName,
    required String userId,
    required DateTime createdAt,
    String? grade,
    String? profileImage,
  }) = _LinkedStudent;

  factory LinkedStudent.fromJson(Map<String, dynamic> json) =>
      _$LinkedStudentFromJson(json);
}
