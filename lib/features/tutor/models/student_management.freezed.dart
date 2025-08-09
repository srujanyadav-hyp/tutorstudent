// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_management.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ManagedStudent _$ManagedStudentFromJson(Map<String, dynamic> json) {
  return _ManagedStudent.fromJson(json);
}

/// @nodoc
mixin _$ManagedStudent {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;
  String? get subjects => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get lastSessionDate => throw _privateConstructorUsedError;
  int get completedSessions => throw _privateConstructorUsedError;
  int get upcomingSessions => throw _privateConstructorUsedError;
  double get averagePerformance => throw _privateConstructorUsedError;

  /// Serializes this ManagedStudent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ManagedStudent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManagedStudentCopyWith<ManagedStudent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagedStudentCopyWith<$Res> {
  factory $ManagedStudentCopyWith(
          ManagedStudent value, $Res Function(ManagedStudent) then) =
      _$ManagedStudentCopyWithImpl<$Res, ManagedStudent>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String email,
      String? grade,
      String? subjects,
      bool isActive,
      DateTime? lastSessionDate,
      int completedSessions,
      int upcomingSessions,
      double averagePerformance});
}

/// @nodoc
class _$ManagedStudentCopyWithImpl<$Res, $Val extends ManagedStudent>
    implements $ManagedStudentCopyWith<$Res> {
  _$ManagedStudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManagedStudent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? email = null,
    Object? grade = freezed,
    Object? subjects = freezed,
    Object? isActive = null,
    Object? lastSessionDate = freezed,
    Object? completedSessions = null,
    Object? upcomingSessions = null,
    Object? averagePerformance = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      subjects: freezed == subjects
          ? _value.subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSessionDate: freezed == lastSessionDate
          ? _value.lastSessionDate
          : lastSessionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedSessions: null == completedSessions
          ? _value.completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingSessions: null == upcomingSessions
          ? _value.upcomingSessions
          : upcomingSessions // ignore: cast_nullable_to_non_nullable
              as int,
      averagePerformance: null == averagePerformance
          ? _value.averagePerformance
          : averagePerformance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ManagedStudentImplCopyWith<$Res>
    implements $ManagedStudentCopyWith<$Res> {
  factory _$$ManagedStudentImplCopyWith(_$ManagedStudentImpl value,
          $Res Function(_$ManagedStudentImpl) then) =
      __$$ManagedStudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String email,
      String? grade,
      String? subjects,
      bool isActive,
      DateTime? lastSessionDate,
      int completedSessions,
      int upcomingSessions,
      double averagePerformance});
}

/// @nodoc
class __$$ManagedStudentImplCopyWithImpl<$Res>
    extends _$ManagedStudentCopyWithImpl<$Res, _$ManagedStudentImpl>
    implements _$$ManagedStudentImplCopyWith<$Res> {
  __$$ManagedStudentImplCopyWithImpl(
      _$ManagedStudentImpl _value, $Res Function(_$ManagedStudentImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManagedStudent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? email = null,
    Object? grade = freezed,
    Object? subjects = freezed,
    Object? isActive = null,
    Object? lastSessionDate = freezed,
    Object? completedSessions = null,
    Object? upcomingSessions = null,
    Object? averagePerformance = null,
  }) {
    return _then(_$ManagedStudentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      subjects: freezed == subjects
          ? _value.subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSessionDate: freezed == lastSessionDate
          ? _value.lastSessionDate
          : lastSessionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedSessions: null == completedSessions
          ? _value.completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingSessions: null == upcomingSessions
          ? _value.upcomingSessions
          : upcomingSessions // ignore: cast_nullable_to_non_nullable
              as int,
      averagePerformance: null == averagePerformance
          ? _value.averagePerformance
          : averagePerformance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ManagedStudentImpl implements _ManagedStudent {
  const _$ManagedStudentImpl(
      {required this.id,
      required this.userId,
      required this.name,
      required this.email,
      this.grade,
      this.subjects,
      this.isActive = false,
      this.lastSessionDate,
      this.completedSessions = 0,
      this.upcomingSessions = 0,
      this.averagePerformance = 0.0});

  factory _$ManagedStudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ManagedStudentImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? grade;
  @override
  final String? subjects;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? lastSessionDate;
  @override
  @JsonKey()
  final int completedSessions;
  @override
  @JsonKey()
  final int upcomingSessions;
  @override
  @JsonKey()
  final double averagePerformance;

  @override
  String toString() {
    return 'ManagedStudent(id: $id, userId: $userId, name: $name, email: $email, grade: $grade, subjects: $subjects, isActive: $isActive, lastSessionDate: $lastSessionDate, completedSessions: $completedSessions, upcomingSessions: $upcomingSessions, averagePerformance: $averagePerformance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManagedStudentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.subjects, subjects) ||
                other.subjects == subjects) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastSessionDate, lastSessionDate) ||
                other.lastSessionDate == lastSessionDate) &&
            (identical(other.completedSessions, completedSessions) ||
                other.completedSessions == completedSessions) &&
            (identical(other.upcomingSessions, upcomingSessions) ||
                other.upcomingSessions == upcomingSessions) &&
            (identical(other.averagePerformance, averagePerformance) ||
                other.averagePerformance == averagePerformance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      name,
      email,
      grade,
      subjects,
      isActive,
      lastSessionDate,
      completedSessions,
      upcomingSessions,
      averagePerformance);

  /// Create a copy of ManagedStudent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ManagedStudentImplCopyWith<_$ManagedStudentImpl> get copyWith =>
      __$$ManagedStudentImplCopyWithImpl<_$ManagedStudentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ManagedStudentImplToJson(
      this,
    );
  }
}

abstract class _ManagedStudent implements ManagedStudent {
  const factory _ManagedStudent(
      {required final String id,
      required final String userId,
      required final String name,
      required final String email,
      final String? grade,
      final String? subjects,
      final bool isActive,
      final DateTime? lastSessionDate,
      final int completedSessions,
      final int upcomingSessions,
      final double averagePerformance}) = _$ManagedStudentImpl;

  factory _ManagedStudent.fromJson(Map<String, dynamic> json) =
      _$ManagedStudentImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  String get email;
  @override
  String? get grade;
  @override
  String? get subjects;
  @override
  bool get isActive;
  @override
  DateTime? get lastSessionDate;
  @override
  int get completedSessions;
  @override
  int get upcomingSessions;
  @override
  double get averagePerformance;

  /// Create a copy of ManagedStudent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ManagedStudentImplCopyWith<_$ManagedStudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudentProgress _$StudentProgressFromJson(Map<String, dynamic> json) {
  return _StudentProgress.fromJson(json);
}

/// @nodoc
mixin _$StudentProgress {
  String get studentId => throw _privateConstructorUsedError;
  List<SessionAttendance> get sessionHistory =>
      throw _privateConstructorUsedError;
  List<AssignmentProgress> get assignments =>
      throw _privateConstructorUsedError;
  Map<String, double> get subjectPerformance =>
      throw _privateConstructorUsedError;

  /// Serializes this StudentProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentProgressCopyWith<StudentProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentProgressCopyWith<$Res> {
  factory $StudentProgressCopyWith(
          StudentProgress value, $Res Function(StudentProgress) then) =
      _$StudentProgressCopyWithImpl<$Res, StudentProgress>;
  @useResult
  $Res call(
      {String studentId,
      List<SessionAttendance> sessionHistory,
      List<AssignmentProgress> assignments,
      Map<String, double> subjectPerformance});
}

/// @nodoc
class _$StudentProgressCopyWithImpl<$Res, $Val extends StudentProgress>
    implements $StudentProgressCopyWith<$Res> {
  _$StudentProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? sessionHistory = null,
    Object? assignments = null,
    Object? subjectPerformance = null,
  }) {
    return _then(_value.copyWith(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionHistory: null == sessionHistory
          ? _value.sessionHistory
          : sessionHistory // ignore: cast_nullable_to_non_nullable
              as List<SessionAttendance>,
      assignments: null == assignments
          ? _value.assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<AssignmentProgress>,
      subjectPerformance: null == subjectPerformance
          ? _value.subjectPerformance
          : subjectPerformance // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentProgressImplCopyWith<$Res>
    implements $StudentProgressCopyWith<$Res> {
  factory _$$StudentProgressImplCopyWith(_$StudentProgressImpl value,
          $Res Function(_$StudentProgressImpl) then) =
      __$$StudentProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String studentId,
      List<SessionAttendance> sessionHistory,
      List<AssignmentProgress> assignments,
      Map<String, double> subjectPerformance});
}

/// @nodoc
class __$$StudentProgressImplCopyWithImpl<$Res>
    extends _$StudentProgressCopyWithImpl<$Res, _$StudentProgressImpl>
    implements _$$StudentProgressImplCopyWith<$Res> {
  __$$StudentProgressImplCopyWithImpl(
      _$StudentProgressImpl _value, $Res Function(_$StudentProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = null,
    Object? sessionHistory = null,
    Object? assignments = null,
    Object? subjectPerformance = null,
  }) {
    return _then(_$StudentProgressImpl(
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionHistory: null == sessionHistory
          ? _value._sessionHistory
          : sessionHistory // ignore: cast_nullable_to_non_nullable
              as List<SessionAttendance>,
      assignments: null == assignments
          ? _value._assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<AssignmentProgress>,
      subjectPerformance: null == subjectPerformance
          ? _value._subjectPerformance
          : subjectPerformance // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentProgressImpl implements _StudentProgress {
  const _$StudentProgressImpl(
      {required this.studentId,
      final List<SessionAttendance> sessionHistory = const [],
      final List<AssignmentProgress> assignments = const [],
      final Map<String, double> subjectPerformance = const {}})
      : _sessionHistory = sessionHistory,
        _assignments = assignments,
        _subjectPerformance = subjectPerformance;

  factory _$StudentProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentProgressImplFromJson(json);

  @override
  final String studentId;
  final List<SessionAttendance> _sessionHistory;
  @override
  @JsonKey()
  List<SessionAttendance> get sessionHistory {
    if (_sessionHistory is EqualUnmodifiableListView) return _sessionHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessionHistory);
  }

  final List<AssignmentProgress> _assignments;
  @override
  @JsonKey()
  List<AssignmentProgress> get assignments {
    if (_assignments is EqualUnmodifiableListView) return _assignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignments);
  }

  final Map<String, double> _subjectPerformance;
  @override
  @JsonKey()
  Map<String, double> get subjectPerformance {
    if (_subjectPerformance is EqualUnmodifiableMapView)
      return _subjectPerformance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_subjectPerformance);
  }

  @override
  String toString() {
    return 'StudentProgress(studentId: $studentId, sessionHistory: $sessionHistory, assignments: $assignments, subjectPerformance: $subjectPerformance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentProgressImpl &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            const DeepCollectionEquality()
                .equals(other._sessionHistory, _sessionHistory) &&
            const DeepCollectionEquality()
                .equals(other._assignments, _assignments) &&
            const DeepCollectionEquality()
                .equals(other._subjectPerformance, _subjectPerformance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      studentId,
      const DeepCollectionEquality().hash(_sessionHistory),
      const DeepCollectionEquality().hash(_assignments),
      const DeepCollectionEquality().hash(_subjectPerformance));

  /// Create a copy of StudentProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentProgressImplCopyWith<_$StudentProgressImpl> get copyWith =>
      __$$StudentProgressImplCopyWithImpl<_$StudentProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentProgressImplToJson(
      this,
    );
  }
}

abstract class _StudentProgress implements StudentProgress {
  const factory _StudentProgress(
      {required final String studentId,
      final List<SessionAttendance> sessionHistory,
      final List<AssignmentProgress> assignments,
      final Map<String, double> subjectPerformance}) = _$StudentProgressImpl;

  factory _StudentProgress.fromJson(Map<String, dynamic> json) =
      _$StudentProgressImpl.fromJson;

  @override
  String get studentId;
  @override
  List<SessionAttendance> get sessionHistory;
  @override
  List<AssignmentProgress> get assignments;
  @override
  Map<String, double> get subjectPerformance;

  /// Create a copy of StudentProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentProgressImplCopyWith<_$StudentProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionAttendance _$SessionAttendanceFromJson(Map<String, dynamic> json) {
  return _SessionAttendance.fromJson(json);
}

/// @nodoc
mixin _$SessionAttendance {
  String get sessionId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  bool get attended => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

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
  $Res call({String sessionId, DateTime date, bool attended, String? notes});
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
    Object? sessionId = null,
    Object? date = null,
    Object? attended = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attended: null == attended
          ? _value.attended
          : attended // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call({String sessionId, DateTime date, bool attended, String? notes});
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
    Object? sessionId = null,
    Object? date = null,
    Object? attended = null,
    Object? notes = freezed,
  }) {
    return _then(_$SessionAttendanceImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attended: null == attended
          ? _value.attended
          : attended // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionAttendanceImpl implements _SessionAttendance {
  const _$SessionAttendanceImpl(
      {required this.sessionId,
      required this.date,
      required this.attended,
      this.notes});

  factory _$SessionAttendanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionAttendanceImplFromJson(json);

  @override
  final String sessionId;
  @override
  final DateTime date;
  @override
  final bool attended;
  @override
  final String? notes;

  @override
  String toString() {
    return 'SessionAttendance(sessionId: $sessionId, date: $date, attended: $attended, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionAttendanceImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.attended, attended) ||
                other.attended == attended) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionId, date, attended, notes);

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
      {required final String sessionId,
      required final DateTime date,
      required final bool attended,
      final String? notes}) = _$SessionAttendanceImpl;

  factory _SessionAttendance.fromJson(Map<String, dynamic> json) =
      _$SessionAttendanceImpl.fromJson;

  @override
  String get sessionId;
  @override
  DateTime get date;
  @override
  bool get attended;
  @override
  String? get notes;

  /// Create a copy of SessionAttendance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionAttendanceImplCopyWith<_$SessionAttendanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssignmentProgress _$AssignmentProgressFromJson(Map<String, dynamic> json) {
  return _AssignmentProgress.fromJson(json);
}

/// @nodoc
mixin _$AssignmentProgress {
  String get assignmentId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  String? get feedback => throw _privateConstructorUsedError;

  /// Serializes this AssignmentProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssignmentProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssignmentProgressCopyWith<AssignmentProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentProgressCopyWith<$Res> {
  factory $AssignmentProgressCopyWith(
          AssignmentProgress value, $Res Function(AssignmentProgress) then) =
      _$AssignmentProgressCopyWithImpl<$Res, AssignmentProgress>;
  @useResult
  $Res call(
      {String assignmentId,
      String title,
      DateTime dueDate,
      bool completed,
      double score,
      String? feedback});
}

/// @nodoc
class _$AssignmentProgressCopyWithImpl<$Res, $Val extends AssignmentProgress>
    implements $AssignmentProgressCopyWith<$Res> {
  _$AssignmentProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssignmentProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignmentId = null,
    Object? title = null,
    Object? dueDate = null,
    Object? completed = null,
    Object? score = null,
    Object? feedback = freezed,
  }) {
    return _then(_value.copyWith(
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssignmentProgressImplCopyWith<$Res>
    implements $AssignmentProgressCopyWith<$Res> {
  factory _$$AssignmentProgressImplCopyWith(_$AssignmentProgressImpl value,
          $Res Function(_$AssignmentProgressImpl) then) =
      __$$AssignmentProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String assignmentId,
      String title,
      DateTime dueDate,
      bool completed,
      double score,
      String? feedback});
}

/// @nodoc
class __$$AssignmentProgressImplCopyWithImpl<$Res>
    extends _$AssignmentProgressCopyWithImpl<$Res, _$AssignmentProgressImpl>
    implements _$$AssignmentProgressImplCopyWith<$Res> {
  __$$AssignmentProgressImplCopyWithImpl(_$AssignmentProgressImpl _value,
      $Res Function(_$AssignmentProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of AssignmentProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignmentId = null,
    Object? title = null,
    Object? dueDate = null,
    Object? completed = null,
    Object? score = null,
    Object? feedback = freezed,
  }) {
    return _then(_$AssignmentProgressImpl(
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentProgressImpl implements _AssignmentProgress {
  const _$AssignmentProgressImpl(
      {required this.assignmentId,
      required this.title,
      required this.dueDate,
      this.completed = false,
      this.score = 0.0,
      this.feedback});

  factory _$AssignmentProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentProgressImplFromJson(json);

  @override
  final String assignmentId;
  @override
  final String title;
  @override
  final DateTime dueDate;
  @override
  @JsonKey()
  final bool completed;
  @override
  @JsonKey()
  final double score;
  @override
  final String? feedback;

  @override
  String toString() {
    return 'AssignmentProgress(assignmentId: $assignmentId, title: $title, dueDate: $dueDate, completed: $completed, score: $score, feedback: $feedback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentProgressImpl &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, assignmentId, title, dueDate, completed, score, feedback);

  /// Create a copy of AssignmentProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentProgressImplCopyWith<_$AssignmentProgressImpl> get copyWith =>
      __$$AssignmentProgressImplCopyWithImpl<_$AssignmentProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentProgressImplToJson(
      this,
    );
  }
}

abstract class _AssignmentProgress implements AssignmentProgress {
  const factory _AssignmentProgress(
      {required final String assignmentId,
      required final String title,
      required final DateTime dueDate,
      final bool completed,
      final double score,
      final String? feedback}) = _$AssignmentProgressImpl;

  factory _AssignmentProgress.fromJson(Map<String, dynamic> json) =
      _$AssignmentProgressImpl.fromJson;

  @override
  String get assignmentId;
  @override
  String get title;
  @override
  DateTime get dueDate;
  @override
  bool get completed;
  @override
  double get score;
  @override
  String? get feedback;

  /// Create a copy of AssignmentProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssignmentProgressImplCopyWith<_$AssignmentProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
