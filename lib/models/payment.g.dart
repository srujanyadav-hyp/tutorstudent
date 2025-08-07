// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      studentId: json['studentId'] as String,
      tutorId: json['tutorId'] as String,
      sessionId: json['sessionId'] as String?,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'INR',
      status: $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']) ??
          PaymentStatus.pending,
      paymentMethod: json['paymentMethod'] as String?,
      paymentDate: DateTime.parse(json['paymentDate'] as String),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'studentId': instance.studentId,
      'tutorId': instance.tutorId,
      'sessionId': instance.sessionId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'paymentMethod': instance.paymentMethod,
      'paymentDate': instance.paymentDate.toIso8601String(),
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.paid: 'paid',
  PaymentStatus.failed: 'failed',
};
