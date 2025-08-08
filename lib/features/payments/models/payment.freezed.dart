// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentTransaction _$PaymentTransactionFromJson(Map<String, dynamic> json) {
  return _PaymentTransaction.fromJson(json);
}

/// @nodoc
mixin _$PaymentTransaction {
  String get id => throw _privateConstructorUsedError;
  String get bookingId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  String get transactionId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PaymentTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentTransactionCopyWith<PaymentTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentTransactionCopyWith<$Res> {
  factory $PaymentTransactionCopyWith(
          PaymentTransaction value, $Res Function(PaymentTransaction) then) =
      _$PaymentTransactionCopyWithImpl<$Res, PaymentTransaction>;
  @useResult
  $Res call(
      {String id,
      String bookingId,
      double amount,
      String status,
      String paymentMethod,
      String transactionId,
      DateTime createdAt});
}

/// @nodoc
class _$PaymentTransactionCopyWithImpl<$Res, $Val extends PaymentTransaction>
    implements $PaymentTransactionCopyWith<$Res> {
  _$PaymentTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = null,
    Object? amount = null,
    Object? status = null,
    Object? paymentMethod = null,
    Object? transactionId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentTransactionImplCopyWith<$Res>
    implements $PaymentTransactionCopyWith<$Res> {
  factory _$$PaymentTransactionImplCopyWith(_$PaymentTransactionImpl value,
          $Res Function(_$PaymentTransactionImpl) then) =
      __$$PaymentTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String bookingId,
      double amount,
      String status,
      String paymentMethod,
      String transactionId,
      DateTime createdAt});
}

/// @nodoc
class __$$PaymentTransactionImplCopyWithImpl<$Res>
    extends _$PaymentTransactionCopyWithImpl<$Res, _$PaymentTransactionImpl>
    implements _$$PaymentTransactionImplCopyWith<$Res> {
  __$$PaymentTransactionImplCopyWithImpl(_$PaymentTransactionImpl _value,
      $Res Function(_$PaymentTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bookingId = null,
    Object? amount = null,
    Object? status = null,
    Object? paymentMethod = null,
    Object? transactionId = null,
    Object? createdAt = null,
  }) {
    return _then(_$PaymentTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentTransactionImpl implements _PaymentTransaction {
  const _$PaymentTransactionImpl(
      {required this.id,
      required this.bookingId,
      required this.amount,
      required this.status,
      required this.paymentMethod,
      required this.transactionId,
      required this.createdAt});

  factory _$PaymentTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String bookingId;
  @override
  final double amount;
  @override
  final String status;
  @override
  final String paymentMethod;
  @override
  final String transactionId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'PaymentTransaction(id: $id, bookingId: $bookingId, amount: $amount, status: $status, paymentMethod: $paymentMethod, transactionId: $transactionId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, bookingId, amount, status,
      paymentMethod, transactionId, createdAt);

  /// Create a copy of PaymentTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentTransactionImplCopyWith<_$PaymentTransactionImpl> get copyWith =>
      __$$PaymentTransactionImplCopyWithImpl<_$PaymentTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentTransactionImplToJson(
      this,
    );
  }
}

abstract class _PaymentTransaction implements PaymentTransaction {
  const factory _PaymentTransaction(
      {required final String id,
      required final String bookingId,
      required final double amount,
      required final String status,
      required final String paymentMethod,
      required final String transactionId,
      required final DateTime createdAt}) = _$PaymentTransactionImpl;

  factory _PaymentTransaction.fromJson(Map<String, dynamic> json) =
      _$PaymentTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get bookingId;
  @override
  double get amount;
  @override
  String get status;
  @override
  String get paymentMethod;
  @override
  String get transactionId;
  @override
  DateTime get createdAt;

  /// Create a copy of PaymentTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentTransactionImplCopyWith<_$PaymentTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WithdrawalRequest _$WithdrawalRequestFromJson(Map<String, dynamic> json) {
  return _WithdrawalRequest.fromJson(json);
}

/// @nodoc
mixin _$WithdrawalRequest {
  String get id => throw _privateConstructorUsedError;
  String get tutorId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Map<String, dynamic> get bankDetails => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get processedAt => throw _privateConstructorUsedError;

  /// Serializes this WithdrawalRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WithdrawalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WithdrawalRequestCopyWith<WithdrawalRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawalRequestCopyWith<$Res> {
  factory $WithdrawalRequestCopyWith(
          WithdrawalRequest value, $Res Function(WithdrawalRequest) then) =
      _$WithdrawalRequestCopyWithImpl<$Res, WithdrawalRequest>;
  @useResult
  $Res call(
      {String id,
      String tutorId,
      double amount,
      String status,
      Map<String, dynamic> bankDetails,
      DateTime createdAt,
      DateTime? processedAt});
}

/// @nodoc
class _$WithdrawalRequestCopyWithImpl<$Res, $Val extends WithdrawalRequest>
    implements $WithdrawalRequestCopyWith<$Res> {
  _$WithdrawalRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WithdrawalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tutorId = null,
    Object? amount = null,
    Object? status = null,
    Object? bankDetails = null,
    Object? createdAt = null,
    Object? processedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tutorId: null == tutorId
          ? _value.tutorId
          : tutorId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      bankDetails: null == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      processedAt: freezed == processedAt
          ? _value.processedAt
          : processedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WithdrawalRequestImplCopyWith<$Res>
    implements $WithdrawalRequestCopyWith<$Res> {
  factory _$$WithdrawalRequestImplCopyWith(_$WithdrawalRequestImpl value,
          $Res Function(_$WithdrawalRequestImpl) then) =
      __$$WithdrawalRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String tutorId,
      double amount,
      String status,
      Map<String, dynamic> bankDetails,
      DateTime createdAt,
      DateTime? processedAt});
}

/// @nodoc
class __$$WithdrawalRequestImplCopyWithImpl<$Res>
    extends _$WithdrawalRequestCopyWithImpl<$Res, _$WithdrawalRequestImpl>
    implements _$$WithdrawalRequestImplCopyWith<$Res> {
  __$$WithdrawalRequestImplCopyWithImpl(_$WithdrawalRequestImpl _value,
      $Res Function(_$WithdrawalRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of WithdrawalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tutorId = null,
    Object? amount = null,
    Object? status = null,
    Object? bankDetails = null,
    Object? createdAt = null,
    Object? processedAt = freezed,
  }) {
    return _then(_$WithdrawalRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tutorId: null == tutorId
          ? _value.tutorId
          : tutorId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      bankDetails: null == bankDetails
          ? _value._bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      processedAt: freezed == processedAt
          ? _value.processedAt
          : processedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawalRequestImpl implements _WithdrawalRequest {
  const _$WithdrawalRequestImpl(
      {required this.id,
      required this.tutorId,
      required this.amount,
      required this.status,
      required final Map<String, dynamic> bankDetails,
      required this.createdAt,
      this.processedAt})
      : _bankDetails = bankDetails;

  factory _$WithdrawalRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawalRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String tutorId;
  @override
  final double amount;
  @override
  final String status;
  final Map<String, dynamic> _bankDetails;
  @override
  Map<String, dynamic> get bankDetails {
    if (_bankDetails is EqualUnmodifiableMapView) return _bankDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_bankDetails);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? processedAt;

  @override
  String toString() {
    return 'WithdrawalRequest(id: $id, tutorId: $tutorId, amount: $amount, status: $status, bankDetails: $bankDetails, createdAt: $createdAt, processedAt: $processedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawalRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tutorId, tutorId) || other.tutorId == tutorId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._bankDetails, _bankDetails) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tutorId,
      amount,
      status,
      const DeepCollectionEquality().hash(_bankDetails),
      createdAt,
      processedAt);

  /// Create a copy of WithdrawalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawalRequestImplCopyWith<_$WithdrawalRequestImpl> get copyWith =>
      __$$WithdrawalRequestImplCopyWithImpl<_$WithdrawalRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawalRequestImplToJson(
      this,
    );
  }
}

abstract class _WithdrawalRequest implements WithdrawalRequest {
  const factory _WithdrawalRequest(
      {required final String id,
      required final String tutorId,
      required final double amount,
      required final String status,
      required final Map<String, dynamic> bankDetails,
      required final DateTime createdAt,
      final DateTime? processedAt}) = _$WithdrawalRequestImpl;

  factory _WithdrawalRequest.fromJson(Map<String, dynamic> json) =
      _$WithdrawalRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get tutorId;
  @override
  double get amount;
  @override
  String get status;
  @override
  Map<String, dynamic> get bankDetails;
  @override
  DateTime get createdAt;
  @override
  DateTime? get processedAt;

  /// Create a copy of WithdrawalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WithdrawalRequestImplCopyWith<_$WithdrawalRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
