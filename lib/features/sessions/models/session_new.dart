// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_new.freezed.dart';
part 'session_new.g.dart';

DateTime _fromJsonRequired(String json) => DateTime.parse(json);
String _toJsonRequired(DateTime date) => date.toIso8601String();

DateTime? _fromJsonNullable(String? json) =>
    json != null ? DateTime.parse(json) : null;
String? _toJsonNullable(DateTime? date) => date?.toIso8601String();

@freezed
class Session with _$Session {
  const factory Session({
    required String id,
    @JsonKey(name: 'tutor_id') required String tutorId,
    @JsonKey(name: 'student_id') required String studentId,
    required String title,
    required String description,
    @JsonKey(
      name: 'scheduled_at',
      fromJson: _fromJsonRequired,
      toJson: _toJsonRequired,
    )
    required DateTime scheduledAt,
    required double amount,
    @Default('pending') String status,
    @JsonKey(name: 'payment_status') @Default('pending') String paymentStatus,
    @JsonKey(
      name: 'completed_at',
      fromJson: _fromJsonNullable,
      toJson: _toJsonNullable,
    )
    DateTime? completedAt,
    @JsonKey(name: 'meeting_url') String? meetingUrl,
    String? notes,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
