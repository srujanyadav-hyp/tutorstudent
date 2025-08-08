import 'package:freezed_annotation/freezed_annotation.dart';

part 'assignment.freezed.dart';
part 'assignment.g.dart';

@freezed
class Assignment with _$Assignment {
  const factory Assignment({
    required String id,
    required String tutorId,
    required String title,
    String? description,
    required DateTime dueDate,
    required DateTime createdAt,
  }) = _Assignment;

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);
}

@freezed
class AssignmentSubmission with _$AssignmentSubmission {
  const factory AssignmentSubmission({
    required String id,
    required String assignmentId,
    required String studentId,
    String? submissionFile,
    String? grade,
    String? feedback,
    required DateTime submittedAt,
  }) = _AssignmentSubmission;

  factory AssignmentSubmission.fromJson(Map<String, dynamic> json) =>
      _$AssignmentSubmissionFromJson(json);
}
