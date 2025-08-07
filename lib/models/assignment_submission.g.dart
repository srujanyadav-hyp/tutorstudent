// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentSubmission _$AssignmentSubmissionFromJson(
        Map<String, dynamic> json) =>
    AssignmentSubmission(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      assignmentId: json['assignmentId'] as String,
      studentId: json['studentId'] as String,
      fileUrl: json['fileUrl'] as String?,
      feedback: json['feedback'] as String?,
      grade: json['grade'] as String?,
    );

Map<String, dynamic> _$AssignmentSubmissionToJson(
        AssignmentSubmission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'assignmentId': instance.assignmentId,
      'studentId': instance.studentId,
      'fileUrl': instance.fileUrl,
      'feedback': instance.feedback,
      'grade': instance.grade,
    };
