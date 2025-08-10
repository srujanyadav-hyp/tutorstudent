// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

enum PaymentStatus { pending, completed, failed, refunded }

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    @JsonKey(name: 'student_id') required String studentId,
    @JsonKey(name: 'tutor_id') required String tutorId,
    @JsonKey(name: 'session_id') String? sessionId,
    required double amount,
    required String currency,
    required String status,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'payment_date') required DateTime paymentDate,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
