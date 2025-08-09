// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

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
  String get tutorId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  String? get videoLink => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  SessionStatus get status => throw _privateConstructorUsedError;
  List<String>? get studentIds => throw _privateConstructorUsedError;
  List<SessionAttendance>? get attendance => throw _privateConstructorUsedError;

  /// Serializes this Session to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call(
      {String id,
      String tutorId,
      String title,
      String? description,
      DateTime scheduledAt,
      String? videoLink,
      DateTime createdAt,
      SessionStatus status,
      List<String>? studentIds,
      List<SessionAttendance>? attendance});
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tutorId = null,
    Object? title = null,
    Object? description = freezed,
    Object? scheduledAt = null,
    Object? videoLink = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? studentIds = freezed,
    Object? attendance = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      videoLink: freezed == videoLink
          ? _value.videoLink
          : videoLink // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SessionStatus,
      studentIds: freezed == studentIds
          ? _value.studentIds
          : studentIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      attendance: freezed == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as List<SessionAttendance>?,
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
      String tutorId,
      String title,
      String? description,
      DateTime scheduledAt,
      String? videoLink,
      DateTime createdAt,
      SessionStatus status,
      List<String>? studentIds,
      List<SessionAttendance>? attendance});
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
      _$SessionImpl _value, $Res Function(_$SessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tutorId = null,
    Object? title = null,
    Object? description = freezed,
    Object? scheduledAt = null,
    Object? videoLink = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? studentIds = freezed,
    Object? attendance = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      videoLink: freezed == videoLink
          ? _value.videoLink
          : videoLink // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SessionStatus,
      studentIds: freezed == studentIds
          ? _value._studentIds
          : studentIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      attendance: freezed == attendance
          ? _value._attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as List<SessionAttendance>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionImpl implements _Session {
  const _$SessionImpl(
      {required this.id,
      required this.tutorId,
      required this.title,
      this.description,
      required this.scheduledAt,
      this.videoLink,
      required this.createdAt,
      this.status = SessionStatus.scheduled,
      final List<String>? studentIds,
      final List<SessionAttendance>? attendance})
      : _studentIds = studentIds,
        _attendance = attendance;

  factory _$SessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionImplFromJson(json);

  @override
  final String id;
  @override
  final String tutorId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime scheduledAt;
  @override
  final String? videoLink;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final SessionStatus status;
  final List<String>? _studentIds;
  @override
  List<String>? get studentIds {
    final value = _studentIds;
    if (value == null) return null;
    if (_studentIds is EqualUnmodifiableListView) return _studentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SessionAttendance>? _attendance;
  @override
  List<SessionAttendance>? get attendance {
    final value = _attendance;
    if (value == null) return null;
    if (_attendance is EqualUnmodifiableListView) return _attendance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Session(id: $id, tutorId: $tutorId, title: $title, description: $description, scheduledAt: $scheduledAt, videoLink: $videoLink, createdAt: $createdAt, status: $status, studentIds: $studentIds, attendance: $attendance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tutorId, tutorId) || other.tutorId == tutorId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.videoLink, videoLink) ||
                other.videoLink == videoLink) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._studentIds, _studentIds) &&
            const DeepCollectionEquality()
                .equals(other._attendance, _attendance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tutorId,
      title,
      description,
      scheduledAt,
      videoLink,
      createdAt,
      status,
      const DeepCollectionEquality().hash(_studentIds),
      const DeepCollectionEquality().hash(_attendance));

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      required final String tutorId,
      required final String title,
      final String? description,
      required final DateTime scheduledAt,
      final String? videoLink,
      required final DateTime createdAt,
      final SessionStatus status,
      final List<String>? studentIds,
      final List<SessionAttendance>? attendance}) = _$SessionImpl;

  factory _Session.fromJson(Map<String, dynamic> json) = _$SessionImpl.fromJson;

  @override
  String get id;
  @override
  String get tutorId;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get scheduledAt;
  @override
  String? get videoLink;
  @override
  DateTime get createdAt;
  @override
  SessionStatus get status;
  @override
  List<String>? get studentIds;
  @override
  List<SessionAttendance>? get attendance;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionAttendance _$SessionAttendanceFromJson(Map<String, dynamic> json) {
  return _SessionAttendance.fromJson(json);
}

/// @nodoc
mixin _$SessionAttendance {
  String get id => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;

  /// Serializes this SessionAttendance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionAttendance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionAttendanceCopyWith<SessionAttendance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionAttendanceCopyWith<$Res> {
  factory $SessionAttendanceCopyWith(
          SessionAttendance value, $Res Function(SessionAttendance) then) =
      _$SessionAttendanceCopyWithImpl<$Res, SessionAttendance>;
  @useResult
  $Res call({String id, String sessionId, String studentId, DateTime joinedAt});
}

/// @nodoc
class _$SessionAttendanceCopyWithImpl<$Res, $Val extends SessionAttendance>
    implements $SessionAttendanceCopyWith<$Res> {
  _$SessionAttendanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionAttendance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? studentId = null,
    Object? joinedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionAttendanceImplCopyWith<$Res>
    implements $SessionAttendanceCopyWith<$Res> {
  factory _$$SessionAttendanceImplCopyWith(_$SessionAttendanceImpl value,
          $Res Function(_$SessionAttendanceImpl) then) =
      __$$SessionAttendanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String sessionId, String studentId, DateTime joinedAt});
}

/// @nodoc
class __$$SessionAttendanceImplCopyWithImpl<$Res>
    extends _$SessionAttendanceCopyWithImpl<$Res, _$SessionAttendanceImpl>
    implements _$$SessionAttendanceImplCopyWith<$Res> {
  __$$SessionAttendanceImplCopyWithImpl(_$SessionAttendanceImpl _value,
      $Res Function(_$SessionAttendanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionAttendance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? studentId = null,
    Object? joinedAt = null,
  }) {
    return _then(_$SessionAttendanceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionAttendanceImpl implements _SessionAttendance {
  const _$SessionAttendanceImpl(
      {required this.id,
      required this.sessionId,
      required this.studentId,
      required this.joinedAt});

  factory _$SessionAttendanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionAttendanceImplFromJson(json);

  @override
  final String id;
  @override
  final String sessionId;
  @override
  final String studentId;
  @override
  final DateTime joinedAt;

  @override
  String toString() {
    return 'SessionAttendance(id: $id, sessionId: $sessionId, studentId: $studentId, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionAttendanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, sessionId, studentId, joinedAt);

  /// Create a copy of SessionAttendance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionAttendanceImplCopyWith<_$SessionAttendanceImpl> get copyWith =>
      __$$SessionAttendanceImplCopyWithImpl<_$SessionAttendanceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionAttendanceImplToJson(
      this,
    );
  }
}

abstract class _SessionAttendance implements SessionAttendance {
  const factory _SessionAttendance(
      {required final String id,
      required final String sessionId,
      required final String studentId,
      required final DateTime joinedAt}) = _$SessionAttendanceImpl;

  factory _SessionAttendance.fromJson(Map<String, dynamic> json) =
      _$SessionAttendanceImpl.fromJson;

  @override
  String get id;
  @override
  String get sessionId;
  @override
  String get studentId;
  @override
  DateTime get joinedAt;

  /// Create a copy of SessionAttendance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionAttendanceImplCopyWith<_$SessionAttendanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
