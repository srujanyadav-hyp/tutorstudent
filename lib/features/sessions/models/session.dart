import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  final String id;
  final String tutorId;
  final String title;
  final String? description;
  final DateTime scheduledAt;
  final String? videoLink;
  final DateTime createdAt;
  final List<SessionAttendance>? attendance;

  Session({
    required this.id,
    required this.tutorId,
    required this.title,
    this.description,
    required this.scheduledAt,
    this.videoLink,
    required this.createdAt,
    this.attendance,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

@JsonSerializable()
class SessionAttendance {
  final String id;
  final String sessionId;
  final String studentId;
  final DateTime joinedAt;

  SessionAttendance({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.joinedAt,
  });

  factory SessionAttendance.fromJson(Map<String, dynamic> json) =>
      _$SessionAttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$SessionAttendanceToJson(this);
}
