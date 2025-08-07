import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'payment.g.dart';

enum PaymentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('paid')
  paid,
  @JsonValue('failed')
  failed,
}

@JsonSerializable()
class Payment extends BaseModel {
  final String studentId;
  final String tutorId;
  final String? sessionId;
  final double amount;
  final String currency;
  final PaymentStatus status;
  final String? paymentMethod;
  final DateTime paymentDate;

  Payment({
    super.id,
    super.createdAt,
    required this.studentId,
    required this.tutorId,
    this.sessionId,
    required this.amount,
    this.currency = 'INR',
    this.status = PaymentStatus.pending,
    this.paymentMethod,
    required this.paymentDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'student_id': studentId,
        'tutor_id': tutorId,
        'session_id': sessionId,
        'amount': amount,
        'currency': currency,
        'status': status.toString().split('.').last,
        'payment_method': paymentMethod,
        'payment_date': paymentDate.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
      };
}
