import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'student.g.dart';

@JsonSerializable()
class Student extends BaseModel {
  final String userId;
  final String tutorId;
  final String? parentId;
  final String? grade;
  final String? subjects;

  Student({
    super.id,
    super.createdAt,
    required this.userId,
    required this.tutorId,
    this.parentId,
    this.grade,
    this.subjects,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StudentToJson(this);

  @override
  Map<String, dynamic> toMap() => {
    'user_id': userId,
    'tutor_id': tutorId,
    'parent_id': parentId,
    'grade': grade,
    'subjects': subjects,
    'created_at': createdAt.toIso8601String(),
  };
}
