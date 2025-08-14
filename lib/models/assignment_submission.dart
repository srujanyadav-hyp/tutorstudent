import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'assignment_submission.g.dart';

@JsonSerializable()
class AssignmentSubmission extends BaseModel {
  final String assignmentId;
  final String studentId;
  final String? fileUrl;
  final String? feedback;
  final String? grade;

  AssignmentSubmission({
    super.id,
    super.createdAt,
    required this.assignmentId,
    required this.studentId,
    this.fileUrl,
    this.feedback,
    this.grade,
  });

  factory AssignmentSubmission.fromJson(Map<String, dynamic> json) =>
      _$AssignmentSubmissionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssignmentSubmissionToJson(this);

  Map<String, dynamic> toMap() => {
    'id': id,
    'assignment_id': assignmentId,
    'student_id': studentId,
    'file_url': fileUrl,
    'feedback': feedback,
    'grade': grade,
    'created_at': createdAt.toIso8601String(),
  };
}
