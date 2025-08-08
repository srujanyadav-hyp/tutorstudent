// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutor_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionMetric _$SessionMetricFromJson(Map<String, dynamic> json) {
  return _SessionMetric.fromJson(json);
}

/// @nodoc
mixin _$SessionMetric {
  DateTime get date => throw _privateConstructorUsedError;
  int get sessionCount => throw _privateConstructorUsedError;

  /// Serializes this SessionMetric to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionMetricCopyWith<SessionMetric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionMetricCopyWith<$Res> {
  factory $SessionMetricCopyWith(
          SessionMetric value, $Res Function(SessionMetric) then) =
      _$SessionMetricCopyWithImpl<$Res, SessionMetric>;
  @useResult
  $Res call({DateTime date, int sessionCount});
}

/// @nodoc
class _$SessionMetricCopyWithImpl<$Res, $Val extends SessionMetric>
    implements $SessionMetricCopyWith<$Res> {
  _$SessionMetricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? sessionCount = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sessionCount: null == sessionCount
          ? _value.sessionCount
          : sessionCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionMetricImplCopyWith<$Res>
    implements $SessionMetricCopyWith<$Res> {
  factory _$$SessionMetricImplCopyWith(
          _$SessionMetricImpl value, $Res Function(_$SessionMetricImpl) then) =
      __$$SessionMetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, int sessionCount});
}

/// @nodoc
class __$$SessionMetricImplCopyWithImpl<$Res>
    extends _$SessionMetricCopyWithImpl<$Res, _$SessionMetricImpl>
    implements _$$SessionMetricImplCopyWith<$Res> {
  __$$SessionMetricImplCopyWithImpl(
      _$SessionMetricImpl _value, $Res Function(_$SessionMetricImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? sessionCount = null,
  }) {
    return _then(_$SessionMetricImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sessionCount: null == sessionCount
          ? _value.sessionCount
          : sessionCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionMetricImpl implements _SessionMetric {
  const _$SessionMetricImpl({required this.date, required this.sessionCount});

  factory _$SessionMetricImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionMetricImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int sessionCount;

  @override
  String toString() {
    return 'SessionMetric(date: $date, sessionCount: $sessionCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionMetricImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.sessionCount, sessionCount) ||
                other.sessionCount == sessionCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, sessionCount);

  /// Create a copy of SessionMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionMetricImplCopyWith<_$SessionMetricImpl> get copyWith =>
      __$$SessionMetricImplCopyWithImpl<_$SessionMetricImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionMetricImplToJson(
      this,
    );
  }
}

abstract class _SessionMetric implements SessionMetric {
  const factory _SessionMetric(
      {required final DateTime date,
      required final int sessionCount}) = _$SessionMetricImpl;

  factory _SessionMetric.fromJson(Map<String, dynamic> json) =
      _$SessionMetricImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get sessionCount;

  /// Create a copy of SessionMetric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionMetricImplCopyWith<_$SessionMetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EarningMetric _$EarningMetricFromJson(Map<String, dynamic> json) {
  return _EarningMetric.fromJson(json);
}

/// @nodoc
mixin _$EarningMetric {
  DateTime get date => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  /// Serializes this EarningMetric to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarningMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarningMetricCopyWith<EarningMetric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarningMetricCopyWith<$Res> {
  factory $EarningMetricCopyWith(
          EarningMetric value, $Res Function(EarningMetric) then) =
      _$EarningMetricCopyWithImpl<$Res, EarningMetric>;
  @useResult
  $Res call({DateTime date, double amount});
}

/// @nodoc
class _$EarningMetricCopyWithImpl<$Res, $Val extends EarningMetric>
    implements $EarningMetricCopyWith<$Res> {
  _$EarningMetricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarningMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EarningMetricImplCopyWith<$Res>
    implements $EarningMetricCopyWith<$Res> {
  factory _$$EarningMetricImplCopyWith(
          _$EarningMetricImpl value, $Res Function(_$EarningMetricImpl) then) =
      __$$EarningMetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, double amount});
}

/// @nodoc
class __$$EarningMetricImplCopyWithImpl<$Res>
    extends _$EarningMetricCopyWithImpl<$Res, _$EarningMetricImpl>
    implements _$$EarningMetricImplCopyWith<$Res> {
  __$$EarningMetricImplCopyWithImpl(
      _$EarningMetricImpl _value, $Res Function(_$EarningMetricImpl) _then)
      : super(_value, _then);

  /// Create a copy of EarningMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? amount = null,
  }) {
    return _then(_$EarningMetricImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarningMetricImpl implements _EarningMetric {
  const _$EarningMetricImpl({required this.date, required this.amount});

  factory _$EarningMetricImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarningMetricImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double amount;

  @override
  String toString() {
    return 'EarningMetric(date: $date, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarningMetricImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, amount);

  /// Create a copy of EarningMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarningMetricImplCopyWith<_$EarningMetricImpl> get copyWith =>
      __$$EarningMetricImplCopyWithImpl<_$EarningMetricImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarningMetricImplToJson(
      this,
    );
  }
}

abstract class _EarningMetric implements EarningMetric {
  const factory _EarningMetric(
      {required final DateTime date,
      required final double amount}) = _$EarningMetricImpl;

  factory _EarningMetric.fromJson(Map<String, dynamic> json) =
      _$EarningMetricImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get amount;

  /// Create a copy of EarningMetric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarningMetricImplCopyWith<_$EarningMetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TutorStats _$TutorStatsFromJson(Map<String, dynamic> json) {
  return _TutorStats.fromJson(json);
}

/// @nodoc
mixin _$TutorStats {
  int get totalStudents => throw _privateConstructorUsedError;
  int get totalSessions => throw _privateConstructorUsedError;
  int get upcomingSessions => throw _privateConstructorUsedError;
  double get totalEarnings => throw _privateConstructorUsedError;
  double get monthlyEarnings => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  int get totalReviews => throw _privateConstructorUsedError;
  Map<String, int> get sessionsPerDay => throw _privateConstructorUsedError;
  List<SessionMetric> get sessionMetrics => throw _privateConstructorUsedError;
  List<EarningMetric> get earningMetrics => throw _privateConstructorUsedError;

  /// Serializes this TutorStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TutorStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TutorStatsCopyWith<TutorStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TutorStatsCopyWith<$Res> {
  factory $TutorStatsCopyWith(
          TutorStats value, $Res Function(TutorStats) then) =
      _$TutorStatsCopyWithImpl<$Res, TutorStats>;
  @useResult
  $Res call(
      {int totalStudents,
      int totalSessions,
      int upcomingSessions,
      double totalEarnings,
      double monthlyEarnings,
      double averageRating,
      int totalReviews,
      Map<String, int> sessionsPerDay,
      List<SessionMetric> sessionMetrics,
      List<EarningMetric> earningMetrics});
}

/// @nodoc
class _$TutorStatsCopyWithImpl<$Res, $Val extends TutorStats>
    implements $TutorStatsCopyWith<$Res> {
  _$TutorStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TutorStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalStudents = null,
    Object? totalSessions = null,
    Object? upcomingSessions = null,
    Object? totalEarnings = null,
    Object? monthlyEarnings = null,
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? sessionsPerDay = null,
    Object? sessionMetrics = null,
    Object? earningMetrics = null,
  }) {
    return _then(_value.copyWith(
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      totalSessions: null == totalSessions
          ? _value.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingSessions: null == upcomingSessions
          ? _value.upcomingSessions
          : upcomingSessions // ignore: cast_nullable_to_non_nullable
              as int,
      totalEarnings: null == totalEarnings
          ? _value.totalEarnings
          : totalEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyEarnings: null == monthlyEarnings
          ? _value.monthlyEarnings
          : monthlyEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      sessionsPerDay: null == sessionsPerDay
          ? _value.sessionsPerDay
          : sessionsPerDay // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      sessionMetrics: null == sessionMetrics
          ? _value.sessionMetrics
          : sessionMetrics // ignore: cast_nullable_to_non_nullable
              as List<SessionMetric>,
      earningMetrics: null == earningMetrics
          ? _value.earningMetrics
          : earningMetrics // ignore: cast_nullable_to_non_nullable
              as List<EarningMetric>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TutorStatsImplCopyWith<$Res>
    implements $TutorStatsCopyWith<$Res> {
  factory _$$TutorStatsImplCopyWith(
          _$TutorStatsImpl value, $Res Function(_$TutorStatsImpl) then) =
      __$$TutorStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalStudents,
      int totalSessions,
      int upcomingSessions,
      double totalEarnings,
      double monthlyEarnings,
      double averageRating,
      int totalReviews,
      Map<String, int> sessionsPerDay,
      List<SessionMetric> sessionMetrics,
      List<EarningMetric> earningMetrics});
}

/// @nodoc
class __$$TutorStatsImplCopyWithImpl<$Res>
    extends _$TutorStatsCopyWithImpl<$Res, _$TutorStatsImpl>
    implements _$$TutorStatsImplCopyWith<$Res> {
  __$$TutorStatsImplCopyWithImpl(
      _$TutorStatsImpl _value, $Res Function(_$TutorStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TutorStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalStudents = null,
    Object? totalSessions = null,
    Object? upcomingSessions = null,
    Object? totalEarnings = null,
    Object? monthlyEarnings = null,
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? sessionsPerDay = null,
    Object? sessionMetrics = null,
    Object? earningMetrics = null,
  }) {
    return _then(_$TutorStatsImpl(
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      totalSessions: null == totalSessions
          ? _value.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingSessions: null == upcomingSessions
          ? _value.upcomingSessions
          : upcomingSessions // ignore: cast_nullable_to_non_nullable
              as int,
      totalEarnings: null == totalEarnings
          ? _value.totalEarnings
          : totalEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyEarnings: null == monthlyEarnings
          ? _value.monthlyEarnings
          : monthlyEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      sessionsPerDay: null == sessionsPerDay
          ? _value._sessionsPerDay
          : sessionsPerDay // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      sessionMetrics: null == sessionMetrics
          ? _value._sessionMetrics
          : sessionMetrics // ignore: cast_nullable_to_non_nullable
              as List<SessionMetric>,
      earningMetrics: null == earningMetrics
          ? _value._earningMetrics
          : earningMetrics // ignore: cast_nullable_to_non_nullable
              as List<EarningMetric>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TutorStatsImpl implements _TutorStats {
  const _$TutorStatsImpl(
      {required this.totalStudents,
      required this.totalSessions,
      required this.upcomingSessions,
      required this.totalEarnings,
      required this.monthlyEarnings,
      required this.averageRating,
      required this.totalReviews,
      required final Map<String, int> sessionsPerDay,
      required final List<SessionMetric> sessionMetrics,
      required final List<EarningMetric> earningMetrics})
      : _sessionsPerDay = sessionsPerDay,
        _sessionMetrics = sessionMetrics,
        _earningMetrics = earningMetrics;

  factory _$TutorStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TutorStatsImplFromJson(json);

  @override
  final int totalStudents;
  @override
  final int totalSessions;
  @override
  final int upcomingSessions;
  @override
  final double totalEarnings;
  @override
  final double monthlyEarnings;
  @override
  final double averageRating;
  @override
  final int totalReviews;
  final Map<String, int> _sessionsPerDay;
  @override
  Map<String, int> get sessionsPerDay {
    if (_sessionsPerDay is EqualUnmodifiableMapView) return _sessionsPerDay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sessionsPerDay);
  }

  final List<SessionMetric> _sessionMetrics;
  @override
  List<SessionMetric> get sessionMetrics {
    if (_sessionMetrics is EqualUnmodifiableListView) return _sessionMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessionMetrics);
  }

  final List<EarningMetric> _earningMetrics;
  @override
  List<EarningMetric> get earningMetrics {
    if (_earningMetrics is EqualUnmodifiableListView) return _earningMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earningMetrics);
  }

  @override
  String toString() {
    return 'TutorStats(totalStudents: $totalStudents, totalSessions: $totalSessions, upcomingSessions: $upcomingSessions, totalEarnings: $totalEarnings, monthlyEarnings: $monthlyEarnings, averageRating: $averageRating, totalReviews: $totalReviews, sessionsPerDay: $sessionsPerDay, sessionMetrics: $sessionMetrics, earningMetrics: $earningMetrics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TutorStatsImpl &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.upcomingSessions, upcomingSessions) ||
                other.upcomingSessions == upcomingSessions) &&
            (identical(other.totalEarnings, totalEarnings) ||
                other.totalEarnings == totalEarnings) &&
            (identical(other.monthlyEarnings, monthlyEarnings) ||
                other.monthlyEarnings == monthlyEarnings) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            const DeepCollectionEquality()
                .equals(other._sessionsPerDay, _sessionsPerDay) &&
            const DeepCollectionEquality()
                .equals(other._sessionMetrics, _sessionMetrics) &&
            const DeepCollectionEquality()
                .equals(other._earningMetrics, _earningMetrics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalStudents,
      totalSessions,
      upcomingSessions,
      totalEarnings,
      monthlyEarnings,
      averageRating,
      totalReviews,
      const DeepCollectionEquality().hash(_sessionsPerDay),
      const DeepCollectionEquality().hash(_sessionMetrics),
      const DeepCollectionEquality().hash(_earningMetrics));

  /// Create a copy of TutorStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TutorStatsImplCopyWith<_$TutorStatsImpl> get copyWith =>
      __$$TutorStatsImplCopyWithImpl<_$TutorStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TutorStatsImplToJson(
      this,
    );
  }
}

abstract class _TutorStats implements TutorStats {
  const factory _TutorStats(
      {required final int totalStudents,
      required final int totalSessions,
      required final int upcomingSessions,
      required final double totalEarnings,
      required final double monthlyEarnings,
      required final double averageRating,
      required final int totalReviews,
      required final Map<String, int> sessionsPerDay,
      required final List<SessionMetric> sessionMetrics,
      required final List<EarningMetric> earningMetrics}) = _$TutorStatsImpl;

  factory _TutorStats.fromJson(Map<String, dynamic> json) =
      _$TutorStatsImpl.fromJson;

  @override
  int get totalStudents;
  @override
  int get totalSessions;
  @override
  int get upcomingSessions;
  @override
  double get totalEarnings;
  @override
  double get monthlyEarnings;
  @override
  double get averageRating;
  @override
  int get totalReviews;
  @override
  Map<String, int> get sessionsPerDay;
  @override
  List<SessionMetric> get sessionMetrics;
  @override
  List<EarningMetric> get earningMetrics;

  /// Create a copy of TutorStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TutorStatsImplCopyWith<_$TutorStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
