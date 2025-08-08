import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'student.g.dart';

@JsonSerializable()
class Student extends BaseModel {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'tutor_id')
  final String tutorId;
  @JsonKey(name: 'parent_id')
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
}
