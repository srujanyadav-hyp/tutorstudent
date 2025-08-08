// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_new.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Session _$SessionFromJson(Map<String, dynamic> json) {
  return _Session.fromJson(json);
}

/// @nodoc
mixin _$Session {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tutor_id')
  String get tutorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  String get studentId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'scheduled_at',
      fromJson: _fromJsonRequired,
      toJson: _toJsonRequired)
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  String get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'completed_at',
      fromJson: _fromJsonNullable,
      toJson: _toJsonNullable)
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'meeting_url')
  String? get meetingUrl => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'tutor_id') String tutorId,
      @JsonKey(name: 'student_id') String studentId,
      String title,
      String description,
      @JsonKey(
          name: 'scheduled_at',
          fromJson: _fromJsonRequired,
          toJson: _toJsonRequired)
      DateTime scheduledAt,
      double amount,
      String status,
      @JsonKey(name: 'payment_status') String paymentStatus,
      @JsonKey(
          name: 'completed_at',
          fromJson: _fromJsonNullable,
          toJson: _toJsonNullable)
      DateTime? completedAt,
      @JsonKey(name: 'meeting_url') String? meetingUrl,
      String? notes});
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tutorId = null,
    Object? studentId = null,
    Object? title = null,
    Object? description = null,
    Object? scheduledAt = null,
    Object? amount = null,
    Object? status = null,
    Object? paymentStatus = null,
    Object? completedAt = freezed,
    Object? meetingUrl = freezed,
    Object? notes = freezed,
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
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      meetingUrl: freezed == meetingUrl
          ? _value.meetingUrl
          : meetingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionImplCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$SessionImplCopyWith(
          _$SessionImpl value, $Res Function(_$SessionImpl) then) =
      __$$SessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'tutor_id') String tutorId,
      @JsonKey(name: 'student_id') String studentId,
      String title,
      String description,
      @JsonKey(
          name: 'scheduled_at',
          fromJson: _fromJsonRequired,
          toJson: _toJsonRequired)
      DateTime scheduledAt,
      double amount,
      String status,
      @JsonKey(name: 'payment_status') String paymentStatus,
      @JsonKey(
          name: 'completed_at',
          fromJson: _fromJsonNullable,
          toJson: _toJsonNullable)
      DateTime? completedAt,
      @JsonKey(name: 'meeting_url') String? meetingUrl,
      String? notes});
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
      _$SessionImpl _value, $Res Function(_$SessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tutorId = null,
    Object? studentId = null,
    Object? title = null,
    Object? description = null,
    Object? scheduledAt = null,
    Object? amount = null,
    Object? status = null,
    Object? paymentStatus = null,
    Object? completedAt = freezed,
    Object? meetingUrl = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$SessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tutorId: null == tutorId
          ? _value.tutorId
          : tutorId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      meetingUrl: freezed == meetingUrl
          ? _value.meetingUrl
          : meetingUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionImpl implements _Session {
  const _$SessionImpl(
      {required this.id,
      @JsonKey(name: 'tutor_id') required this.tutorId,
      @JsonKey(name: 'student_id') required this.studentId,
      required this.title,
      required this.description,
      @JsonKey(
          name: 'scheduled_at',
          fromJson: _fromJsonRequired,
          toJson: _toJsonRequired)
      required this.scheduledAt,
      required this.amount,
      this.status = 'pending',
      @JsonKey(name: 'payment_status') this.paymentStatus = 'pending',
      @JsonKey(
          name: 'completed_at',
          fromJson: _fromJsonNullable,
          toJson: _toJsonNullable)
      this.completedAt,
      @JsonKey(name: 'meeting_url') this.meetingUrl,
      this.notes});

  factory _$SessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'tutor_id')
  final String tutorId;
  @override
  @JsonKey(name: 'student_id')
  final String studentId;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(
      name: 'scheduled_at',
      fromJson: _fromJsonRequired,
      toJson: _toJsonRequired)
  final DateTime scheduledAt;
  @override
  final double amount;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'payment_status')
  final String paymentStatus;
  @override
  @JsonKey(
      name: 'completed_at',
      fromJson: _fromJsonNullable,
      toJson: _toJsonNullable)
  final DateTime? completedAt;
  @override
  @JsonKey(name: 'meeting_url')
  final String? meetingUrl;
  @override
  final String? notes;

  @override
  String toString() {
    return 'Session(id: $id, tutorId: $tutorId, studentId: $studentId, title: $title, description: $description, scheduledAt: $scheduledAt, amount: $amount, status: $status, paymentStatus: $paymentStatus, completedAt: $completedAt, meetingUrl: $meetingUrl, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tutorId, tutorId) || other.tutorId == tutorId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.meetingUrl, meetingUrl) ||
                other.meetingUrl == meetingUrl) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tutorId,
      studentId,
      title,
      description,
      scheduledAt,
      amount,
      status,
      paymentStatus,
      completedAt,
      meetingUrl,
      notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      __$$SessionImplCopyWithImpl<_$SessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionImplToJson(
      this,
    );
  }
}

abstract class _Session implements Session {
  const factory _Session(
      {required final String id,
      @JsonKey(name: 'tutor_id') required final String tutorId,
      @JsonKey(name: 'student_id') required final String studentId,
      required final String title,
      required final String description,
      @JsonKey(
          name: 'scheduled_at',
          fromJson: _fromJsonRequired,
          toJson: _toJsonRequired)
      required final DateTime scheduledAt,
      required final double amount,
      final String status,
      @JsonKey(name: 'payment_status') final String paymentStatus,
      @JsonKey(
          name: 'completed_at',
          fromJson: _fromJsonNullable,
          toJson: _toJsonNullable)
      final DateTime? completedAt,
      @JsonKey(name: 'meeting_url') final String? meetingUrl,
      final String? notes}) = _$SessionImpl;

  factory _Session.fromJson(Map<String, dynamic> json) = _$SessionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'tutor_id')
  String get tutorId;
  @override
  @JsonKey(name: 'student_id')
  String get studentId;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(
      name: 'scheduled_at',
      fromJson: _fromJsonRequired,
      toJson: _toJsonRequired)
  DateTime get scheduledAt;
  @override
  double get amount;
  @override
  String get status;
  @override
  @JsonKey(name: 'payment_status')
  String get paymentStatus;
  @override
  @JsonKey(
      name: 'completed_at',
      fromJson: _fromJsonNullable,
      toJson: _toJsonNullable)
  DateTime? get completedAt;
  @override
  @JsonKey(name: 'meeting_url')
  String? get meetingUrl;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
