// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssignmentImpl _$$AssignmentImplFromJson(Map<String, dynamic> json) =>
    _$AssignmentImpl(
      id: json['id'] as String,
      tutorId: json['tutorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      dueDate: DateTime.parse(json['dueDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AssignmentImplToJson(_$AssignmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$AssignmentSubmissionImpl _$$AssignmentSubmissionImplFromJson(
        Map<String, dynamic> json) =>
    _$AssignmentSubmissionImpl(
      id: json['id'] as String,
      assignmentId: json['assignmentId'] as String,
      studentId: json['studentId'] as String,
      submissionFile: json['submissionFile'] as String?,
      grade: json['grade'] as String?,
      feedback: json['feedback'] as String?,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
    );

Map<String, dynamic> _$$AssignmentSubmissionImplToJson(
        _$AssignmentSubmissionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assignmentId': instance.assignmentId,
      'studentId': instance.studentId,
      'submissionFile': instance.submissionFile,
      'grade': instance.grade,
      'feedback': instance.feedback,
      'submittedAt': instance.submittedAt.toIso8601String(),
    };
