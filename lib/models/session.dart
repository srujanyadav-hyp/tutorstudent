// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

enum SessionStatus { upcoming, ongoing, completed, cancelled }

@freezed
class Session with _$Session {
  const factory Session({
    required String id,
    @JsonKey(name: 'tutor_id') required String tutorId,
    @JsonKey(name: 'student_id') required String studentId,
    required String title,
    @JsonKey(name: 'scheduled_at') required DateTime scheduledAt,
    required int duration,
    @JsonKey(name: 'meeting_link') String? meetingLink,
    required String status,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
