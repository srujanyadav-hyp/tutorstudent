import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_booking.freezed.dart';
part 'session_booking.g.dart';

enum SessionBookingStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('completed')
  completed,
}

@freezed
class SessionBooking with _$SessionBooking {
  const factory SessionBooking({
    required String id,
    required String studentId,
    required String tutorId,
    required DateTime startTime,
    required DateTime endTime,
    String? topic,
    String? notes,
    @Default(SessionBookingStatus.pending) SessionBookingStatus status,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _SessionBooking;

  factory SessionBooking.fromJson(Map<String, dynamic> json) =>
      _$SessionBookingFromJson(json);
}
