// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StudentProfile _$StudentProfileFromJson(Map<String, dynamic> json) {
  return _StudentProfile.fromJson(json);
}

/// @nodoc
mixin _$StudentProfile {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;
  String? get subjects => throw _privateConstructorUsedError;
  DateTime? get joinedAt => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  List<String> get enrolledSubjects => throw _privateConstructorUsedError;
  int get completedSessions => throw _privateConstructorUsedError;
  int get upcomingSessions => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;

  /// Serializes this StudentProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentProfileCopyWith<StudentProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentProfileCopyWith<$Res> {
  factory $StudentProfileCopyWith(
          StudentProfile value, $Res Function(StudentProfile) then) =
      _$StudentProfileCopyWithImpl<$Res, StudentProfile>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String fullName,
      String email,
      String? grade,
      String? subjects,
      DateTime? joinedAt,
      String? profileImage,
      bool isActive,
      List<String> enrolledSubjects,
      int completedSessions,
      int upcomingSessions,
      double averageRating});
}

/// @nodoc
class _$StudentProfileCopyWithImpl<$Res, $Val extends StudentProfile>
    implements $StudentProfileCopyWith<$Res> {
  _$StudentProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = null,
    Object? email = null,
    Object? grade = freezed,
    Object? subjects = freezed,
    Object? joinedAt = freezed,
    Object? profileImage = freezed,
    Object? isActive = null,
    Object? enrolledSubjects = null,
    Object? completedSessions = null,
    Object? upcomingSessions = null,
    Object? averageRating = null,
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
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
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
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      enrolledSubjects: null == enrolledSubjects
          ? _value.enrolledSubjects
          : enrolledSubjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      completedSessions: null == completedSessions
          ? _value.completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingSessions: null == upcomingSessions
          ? _value.upcomingSessions
          : upcomingSessions // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentProfileImplCopyWith<$Res>
    implements $StudentProfileCopyWith<$Res> {
  factory _$$StudentProfileImplCopyWith(_$StudentProfileImpl value,
          $Res Function(_$StudentProfileImpl) then) =
      __$$StudentProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String fullName,
      String email,
      String? grade,
      String? subjects,
      DateTime? joinedAt,
      String? profileImage,
      bool isActive,
      List<String> enrolledSubjects,
      int completedSessions,
      int upcomingSessions,
      double averageRating});
}

/// @nodoc
class __$$StudentProfileImplCopyWithImpl<$Res>
    extends _$StudentProfileCopyWithImpl<$Res, _$StudentProfileImpl>
    implements _$$StudentProfileImplCopyWith<$Res> {
  __$$StudentProfileImplCopyWithImpl(
      _$StudentProfileImpl _value, $Res Function(_$StudentProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = null,
    Object? email = null,
    Object? grade = freezed,
    Object? subjects = freezed,
    Object? joinedAt = freezed,
    Object? profileImage = freezed,
    Object? isActive = null,
    Object? enrolledSubjects = null,
    Object? completedSessions = null,
    Object? upcomingSessions = null,
    Object? averageRating = null,
  }) {
    return _then(_$StudentProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
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
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      enrolledSubjects: null == enrolledSubjects
          ? _value._enrolledSubjects
          : enrolledSubjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      completedSessions: null == completedSessions
          ? _value.completedSessions
          : completedSessions // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingSessions: null == upcomingSessions
          ? _value.upcomingSessions
          : upcomingSessions // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentProfileImpl implements _StudentProfile {
  const _$StudentProfileImpl(
      {required this.id,
      required this.userId,
      required this.fullName,
      required this.email,
      this.grade,
      this.subjects,
      this.joinedAt,
      this.profileImage,
      this.isActive = false,
      final List<String> enrolledSubjects = const [],
      this.completedSessions = 0,
      this.upcomingSessions = 0,
      this.averageRating = 0.0})
      : _enrolledSubjects = enrolledSubjects;

  factory _$StudentProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String fullName;
  @override
  final String email;
  @override
  final String? grade;
  @override
  final String? subjects;
  @override
  final DateTime? joinedAt;
  @override
  final String? profileImage;
  @override
  @JsonKey()
  final bool isActive;
  final List<String> _enrolledSubjects;
  @override
  @JsonKey()
  List<String> get enrolledSubjects {
    if (_enrolledSubjects is EqualUnmodifiableListView)
      return _enrolledSubjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enrolledSubjects);
  }

  @override
  @JsonKey()
  final int completedSessions;
  @override
  @JsonKey()
  final int upcomingSessions;
  @override
  @JsonKey()
  final double averageRating;

  @override
  String toString() {
    return 'StudentProfile(id: $id, userId: $userId, fullName: $fullName, email: $email, grade: $grade, subjects: $subjects, joinedAt: $joinedAt, profileImage: $profileImage, isActive: $isActive, enrolledSubjects: $enrolledSubjects, completedSessions: $completedSessions, upcomingSessions: $upcomingSessions, averageRating: $averageRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.subjects, subjects) ||
                other.subjects == subjects) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality()
                .equals(other._enrolledSubjects, _enrolledSubjects) &&
            (identical(other.completedSessions, completedSessions) ||
                other.completedSessions == completedSessions) &&
            (identical(other.upcomingSessions, upcomingSessions) ||
                other.upcomingSessions == upcomingSessions) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      fullName,
      email,
      grade,
      subjects,
      joinedAt,
      profileImage,
      isActive,
      const DeepCollectionEquality().hash(_enrolledSubjects),
      completedSessions,
      upcomingSessions,
      averageRating);

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentProfileImplCopyWith<_$StudentProfileImpl> get copyWith =>
      __$$StudentProfileImplCopyWithImpl<_$StudentProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentProfileImplToJson(
      this,
    );
  }
}

abstract class _StudentProfile implements StudentProfile {
  const factory _StudentProfile(
      {required final String id,
      required final String userId,
      required final String fullName,
      required final String email,
      final String? grade,
      final String? subjects,
      final DateTime? joinedAt,
      final String? profileImage,
      final bool isActive,
      final List<String> enrolledSubjects,
      final int completedSessions,
      final int upcomingSessions,
      final double averageRating}) = _$StudentProfileImpl;

  factory _StudentProfile.fromJson(Map<String, dynamic> json) =
      _$StudentProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get fullName;
  @override
  String get email;
  @override
  String? get grade;
  @override
  String? get subjects;
  @override
  DateTime? get joinedAt;
  @override
  String? get profileImage;
  @override
  bool get isActive;
  @override
  List<String> get enrolledSubjects;
  @override
  int get completedSessions;
  @override
  int get upcomingSessions;
  @override
  double get averageRating;

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentProfileImplCopyWith<_$StudentProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
