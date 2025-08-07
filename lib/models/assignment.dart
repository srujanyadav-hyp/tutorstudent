import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'assignment.g.dart';

@JsonSerializable()
class Assignment extends BaseModel {
  final String tutorId;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final String? subject;

  Assignment({
    super.id,
    super.createdAt,
    required this.tutorId,
    required this.title,
    this.description,
    this.dueDate,
    this.subject,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssignmentToJson(this);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'tutor_id': tutorId,
        'title': title,
        'description': description,
        'due_date': dueDate?.toIso8601String(),
        'subject': subject,
        'created_at': createdAt.toIso8601String(),
      };
}
