// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionBooking _$SessionBookingFromJson(Map<String, dynamic> json) {
  return _SessionBooking.fromJson(json);
}

/// @nodoc
mixin _$SessionBooking {
  String get id => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get tutorId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String? get topic => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  SessionBookingStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SessionBooking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionBooking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionBookingCopyWith<SessionBooking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionBookingCopyWith<$Res> {
  factory $SessionBookingCopyWith(
          SessionBooking value, $Res Function(SessionBooking) then) =
      _$SessionBookingCopyWithImpl<$Res, SessionBooking>;
  @useResult
  $Res call(
      {String id,
      String studentId,
      String tutorId,
      DateTime startTime,
      DateTime endTime,
      String? topic,
      String? notes,
      SessionBookingStatus status,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$SessionBookingCopyWithImpl<$Res, $Val extends SessionBooking>
    implements $SessionBookingCopyWith<$Res> {
  _$SessionBookingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionBooking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? tutorId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? topic = freezed,
    Object? notes = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      tutorId: null == tutorId
          ? _value.tutorId
          : tutorId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SessionBookingStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionBookingImplCopyWith<$Res>
    implements $SessionBookingCopyWith<$Res> {
  factory _$$SessionBookingImplCopyWith(_$SessionBookingImpl value,
          $Res Function(_$SessionBookingImpl) then) =
      __$$SessionBookingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String studentId,
      String tutorId,
      DateTime startTime,
      DateTime endTime,
      String? topic,
      String? notes,
      SessionBookingStatus status,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$SessionBookingImplCopyWithImpl<$Res>
    extends _$SessionBookingCopyWithImpl<$Res, _$SessionBookingImpl>
    implements _$$SessionBookingImplCopyWith<$Res> {
  __$$SessionBookingImplCopyWithImpl(
      _$SessionBookingImpl _value, $Res Function(_$SessionBookingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionBooking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? tutorId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? topic = freezed,
    Object? notes = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$SessionBookingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      tutorId: null == tutorId
          ? _value.tutorId
          : tutorId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SessionBookingStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionBookingImpl implements _SessionBooking {
  const _$SessionBookingImpl(
      {required this.id,
      required this.studentId,
      required this.tutorId,
      required this.startTime,
      required this.endTime,
      this.topic,
      this.notes,
      this.status = SessionBookingStatus.pending,
      required this.createdAt,
      this.updatedAt});

  factory _$SessionBookingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionBookingImplFromJson(json);

  @override
  final String id;
  @override
  final String studentId;
  @override
  final String tutorId;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String? topic;
  @override
  final String? notes;
  @override
  @JsonKey()
  final SessionBookingStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'SessionBooking(id: $id, studentId: $studentId, tutorId: $tutorId, startTime: $startTime, endTime: $endTime, topic: $topic, notes: $notes, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionBookingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.tutorId, tutorId) || other.tutorId == tutorId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, studentId, tutorId,
      startTime, endTime, topic, notes, status, createdAt, updatedAt);

  /// Create a copy of SessionBooking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionBookingImplCopyWith<_$SessionBookingImpl> get copyWith =>
      __$$SessionBookingImplCopyWithImpl<_$SessionBookingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionBookingImplToJson(
      this,
    );
  }
}

abstract class _SessionBooking implements SessionBooking {
  const factory _SessionBooking(
      {required final String id,
      required final String studentId,
      required final String tutorId,
      required final DateTime startTime,
      required final DateTime endTime,
      final String? topic,
      final String? notes,
      final SessionBookingStatus status,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$SessionBookingImpl;

  factory _SessionBooking.fromJson(Map<String, dynamic> json) =
      _$SessionBookingImpl.fromJson;

  @override
  String get id;
  @override
  String get studentId;
  @override
  String get tutorId;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String? get topic;
  @override
  String? get notes;
  @override
  SessionBookingStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of SessionBooking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionBookingImplCopyWith<_$SessionBookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
