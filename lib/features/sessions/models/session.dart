import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

enum SessionStatus {
  @JsonValue('scheduled')
  scheduled,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

@freezed
class Session with _$Session {
  const factory Session({
    required String id,
    required String tutorId,
    required String title,
    String? description,
    required DateTime scheduledAt,
    String? videoLink,
    required DateTime createdAt,
    @Default(SessionStatus.scheduled) SessionStatus status,
    List<String>? studentIds,
    List<SessionAttendance>? attendance,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}

@freezed
class SessionAttendance with _$SessionAttendance {
  const factory SessionAttendance({
    required String id,
    required String sessionId,
    required String studentId,
    required DateTime joinedAt,
  }) = _SessionAttendance;

  factory SessionAttendance.fromJson(Map<String, dynamic> json) =>
      _$SessionAttendanceFromJson(json);
}
