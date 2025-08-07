import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'session.g.dart';

enum SessionStatus {
  @JsonValue('upcoming')
  upcoming,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

@JsonSerializable()
class Session extends BaseModel {
  final String tutorId;
  final String studentId;
  final String title;
  final DateTime scheduledAt;
  final int duration;
  final String? meetingLink;
  final SessionStatus status;

  Session({
    super.id,
    super.createdAt,
    required this.tutorId,
    required this.studentId,
    required this.title,
    required this.scheduledAt,
    required this.duration,
    this.meetingLink,
    this.status = SessionStatus.upcoming,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  Map<String, dynamic> toMap() => {
    'tutor_id': tutorId,
    'student_id': studentId,
    'title': title,
    'scheduled_at': scheduledAt.toIso8601String(),
    'duration': duration,
    'meeting_link': meetingLink,
    'status': status.toString().split('.').last,
    'created_at': createdAt.toIso8601String(),
  };
}
