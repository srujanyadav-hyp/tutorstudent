// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_dashboard_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ParentDashboardStats _$ParentDashboardStatsFromJson(Map<String, dynamic> json) {
  return _ParentDashboardStats.fromJson(json);
}

/// @nodoc
mixin _$ParentDashboardStats {
  int get totalStudents => throw _privateConstructorUsedError;
  int get upcomingSessions => throw _privateConstructorUsedError;
  double get totalSpent => throw _privateConstructorUsedError;
  int get pendingPayments => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get recentActivities =>
      throw _privateConstructorUsedError;

  /// Serializes this ParentDashboardStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParentDashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParentDashboardStatsCopyWith<ParentDashboardStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParentDashboardStatsCopyWith<$Res> {
  factory $ParentDashboardStatsCopyWith(ParentDashboardStats value,
          $Res Function(ParentDashboardStats) then) =
      _$ParentDashboardStatsCopyWithImpl<$Res, ParentDashboardStats>;
  @useResult
  $Res call(
      {int totalStudents,
      int upcomingSessions,
      double totalSpent,
      int pendingPayments,
      List<Map<String, dynamic>> recentActivities});
}

/// @nodoc
class _$ParentDashboardStatsCopyWithImpl<$Res,
        $Val extends ParentDashboardStats>
    implements $ParentDashboardStatsCopyWith<$Res> {
  _$ParentDashboardStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParentDashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalStudents = null,
    Object? upcomingSessions = null,
    Object? totalSpent = null,
    Object? pendingPayments = null,
    Object? recentActivities = null,
  }) {
    return _then(_value.copyWith(
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingSessions: null == upcomingSessions
          ? _value.upcomingSessions
          : upcomingSessions // ignore: cast_nullable_to_non_nullable
              as int,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      pendingPayments: null == pendingPayments
          ? _value.pendingPayments
          : pendingPayments // ignore: cast_nullable_to_non_nullable
              as int,
      recentActivities: null == recentActivities
          ? _value.recentActivities
          : recentActivities // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParentDashboardStatsImplCopyWith<$Res>
    implements $ParentDashboardStatsCopyWith<$Res> {
  factory _$$ParentDashboardStatsImplCopyWith(_$ParentDashboardStatsImpl value,
          $Res Function(_$ParentDashboardStatsImpl) then) =
      __$$ParentDashboardStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalStudents,
      int upcomingSessions,
      double totalSpent,
      int pendingPayments,
      List<Map<String, dynamic>> recentActivities});
}

/// @nodoc
class __$$ParentDashboardStatsImplCopyWithImpl<$Res>
    extends _$ParentDashboardStatsCopyWithImpl<$Res, _$ParentDashboardStatsImpl>
    implements _$$ParentDashboardStatsImplCopyWith<$Res> {
  __$$ParentDashboardStatsImplCopyWithImpl(_$ParentDashboardStatsImpl _value,
      $Res Function(_$ParentDashboardStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ParentDashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalStudents = null,
    Object? upcomingSessions = null,
    Object? totalSpent = null,
    Object? pendingPayments = null,
    Object? recentActivities = null,
  }) {
    return _then(_$ParentDashboardStatsImpl(
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingSessions: null == upcomingSessions
          ? _value.upcomingSessions
          : upcomingSessions // ignore: cast_nullable_to_non_nullable
              as int,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      pendingPayments: null == pendingPayments
          ? _value.pendingPayments
          : pendingPayments // ignore: cast_nullable_to_non_nullable
              as int,
      recentActivities: null == recentActivities
          ? _value._recentActivities
          : recentActivities // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParentDashboardStatsImpl implements _ParentDashboardStats {
  const _$ParentDashboardStatsImpl(
      {required this.totalStudents,
      required this.upcomingSessions,
      required this.totalSpent,
      required this.pendingPayments,
      required final List<Map<String, dynamic>> recentActivities})
      : _recentActivities = recentActivities;

  factory _$ParentDashboardStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParentDashboardStatsImplFromJson(json);

  @override
  final int totalStudents;
  @override
  final int upcomingSessions;
  @override
  final double totalSpent;
  @override
  final int pendingPayments;
  final List<Map<String, dynamic>> _recentActivities;
  @override
  List<Map<String, dynamic>> get recentActivities {
    if (_recentActivities is EqualUnmodifiableListView)
      return _recentActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentActivities);
  }

  @override
  String toString() {
    return 'ParentDashboardStats(totalStudents: $totalStudents, upcomingSessions: $upcomingSessions, totalSpent: $totalSpent, pendingPayments: $pendingPayments, recentActivities: $recentActivities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParentDashboardStatsImpl &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.upcomingSessions, upcomingSessions) ||
                other.upcomingSessions == upcomingSessions) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.pendingPayments, pendingPayments) ||
                other.pendingPayments == pendingPayments) &&
            const DeepCollectionEquality()
                .equals(other._recentActivities, _recentActivities));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalStudents,
      upcomingSessions,
      totalSpent,
      pendingPayments,
      const DeepCollectionEquality().hash(_recentActivities));

  /// Create a copy of ParentDashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParentDashboardStatsImplCopyWith<_$ParentDashboardStatsImpl>
      get copyWith =>
          __$$ParentDashboardStatsImplCopyWithImpl<_$ParentDashboardStatsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParentDashboardStatsImplToJson(
      this,
    );
  }
}

abstract class _ParentDashboardStats implements ParentDashboardStats {
  const factory _ParentDashboardStats(
          {required final int totalStudents,
          required final int upcomingSessions,
          required final double totalSpent,
          required final int pendingPayments,
          required final List<Map<String, dynamic>> recentActivities}) =
      _$ParentDashboardStatsImpl;

  factory _ParentDashboardStats.fromJson(Map<String, dynamic> json) =
      _$ParentDashboardStatsImpl.fromJson;

  @override
  int get totalStudents;
  @override
  int get upcomingSessions;
  @override
  double get totalSpent;
  @override
  int get pendingPayments;
  @override
  List<Map<String, dynamic>> get recentActivities;

  /// Create a copy of ParentDashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParentDashboardStatsImplCopyWith<_$ParentDashboardStatsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
