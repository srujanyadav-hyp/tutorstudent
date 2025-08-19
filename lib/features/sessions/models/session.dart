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

  factory Session.fromJson(Map<String, dynamic> json) {
    return _Session(
      id: json['id']?.toString() ?? '',
      tutorId:
          json['tutorId']?.toString() ?? json['tutor_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.parse(json['scheduledAt'].toString())
          : (json['scheduled_at'] != null
                ? DateTime.parse(json['scheduled_at'].toString())
                : DateTime.now()),
      videoLink:
          json['videoLink']?.toString() ?? json['video_link']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : (json['created_at'] != null
                ? DateTime.parse(json['created_at'].toString())
                : DateTime.now()),
      status: json['status'] != null
          ? SessionStatus.values.firstWhere(
              (e) => e.name == json['status'] || e.toString() == json['status'],
              orElse: () => SessionStatus.scheduled,
            )
          : SessionStatus.scheduled,
      studentIds: (json['studentIds'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      attendance: (json['attendance'] as List?)
          ?.map((e) => SessionAttendance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

@freezed
class SessionAttendance with _$SessionAttendance {
  const factory SessionAttendance({
    required String id,
    required String sessionId,
    required String studentId,
    required DateTime joinedAt,
  }) = _SessionAttendance;

  factory SessionAttendance.fromJson(Map<String, dynamic> json) {
    return _SessionAttendance(
      id: json['id']?.toString() ?? '',
      sessionId:
          json['sessionId']?.toString() ?? json['session_id']?.toString() ?? '',
      studentId:
          json['studentId']?.toString() ?? json['student_id']?.toString() ?? '',
      joinedAt: json['joinedAt'] != null
          ? DateTime.parse(json['joinedAt'].toString())
          : (json['joined_at'] != null
                ? DateTime.parse(json['joined_at'].toString())
                : DateTime.now()),
    );
  }
}
