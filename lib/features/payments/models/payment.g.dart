// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentTransactionImpl _$$PaymentTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentTransactionImpl(
      id: json['id'] as String,
      bookingId: json['bookingId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      paymentMethod: json['paymentMethod'] as String,
      transactionId: json['transactionId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PaymentTransactionImplToJson(
        _$PaymentTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'amount': instance.amount,
      'status': instance.status,
      'paymentMethod': instance.paymentMethod,
      'transactionId': instance.transactionId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$WithdrawalRequestImpl _$$WithdrawalRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WithdrawalRequestImpl(
      id: json['id'] as String,
      tutorId: json['tutorId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      bankDetails: json['bankDetails'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
    );

Map<String, dynamic> _$$WithdrawalRequestImplToJson(
        _$WithdrawalRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'amount': instance.amount,
      'status': instance.status,
      'bankDetails': instance.bankDetails,
      'createdAt': instance.createdAt.toIso8601String(),
      'processedAt': instance.processedAt?.toIso8601String(),
    };
