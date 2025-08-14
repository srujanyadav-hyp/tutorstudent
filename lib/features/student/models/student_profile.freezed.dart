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
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;
  List<String> get subjects => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  List<String> get tutorIds => throw _privateConstructorUsedError;
  Map<String, double> get subjectProgress => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

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
      String name,
      String email,
      String? grade,
      List<String> subjects,
      String? parentId,
      List<String> tutorIds,
      Map<String, double> subjectProgress,
      DateTime createdAt});
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
    Object? name = null,
    Object? email = null,
    Object? grade = freezed,
    Object? subjects = null,
    Object? parentId = freezed,
    Object? tutorIds = null,
    Object? subjectProgress = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      subjects: null == subjects
          ? _value.subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      tutorIds: null == tutorIds
          ? _value.tutorIds
          : tutorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      subjectProgress: null == subjectProgress
          ? _value.subjectProgress
          : subjectProgress // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      String name,
      String email,
      String? grade,
      List<String> subjects,
      String? parentId,
      List<String> tutorIds,
      Map<String, double> subjectProgress,
      DateTime createdAt});
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
    Object? name = null,
    Object? email = null,
    Object? grade = freezed,
    Object? subjects = null,
    Object? parentId = freezed,
    Object? tutorIds = null,
    Object? subjectProgress = null,
    Object? createdAt = null,
  }) {
    return _then(_$StudentProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      subjects: null == subjects
          ? _value._subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<String>,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      tutorIds: null == tutorIds
          ? _value._tutorIds
          : tutorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      subjectProgress: null == subjectProgress
          ? _value._subjectProgress
          : subjectProgress // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentProfileImpl implements _StudentProfile {
  const _$StudentProfileImpl(
      {required this.id,
      required this.name,
      required this.email,
      this.grade,
      required final List<String> subjects,
      this.parentId,
      required final List<String> tutorIds,
      required final Map<String, double> subjectProgress,
      required this.createdAt})
      : _subjects = subjects,
        _tutorIds = tutorIds,
        _subjectProgress = subjectProgress;

  factory _$StudentProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? grade;
  final List<String> _subjects;
  @override
  List<String> get subjects {
    if (_subjects is EqualUnmodifiableListView) return _subjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subjects);
  }

  @override
  final String? parentId;
  final List<String> _tutorIds;
  @override
  List<String> get tutorIds {
    if (_tutorIds is EqualUnmodifiableListView) return _tutorIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tutorIds);
  }

  final Map<String, double> _subjectProgress;
  @override
  Map<String, double> get subjectProgress {
    if (_subjectProgress is EqualUnmodifiableMapView) return _subjectProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_subjectProgress);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'StudentProfile(id: $id, name: $name, email: $email, grade: $grade, subjects: $subjects, parentId: $parentId, tutorIds: $tutorIds, subjectProgress: $subjectProgress, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            const DeepCollectionEquality().equals(other._subjects, _subjects) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            const DeepCollectionEquality().equals(other._tutorIds, _tutorIds) &&
            const DeepCollectionEquality()
                .equals(other._subjectProgress, _subjectProgress) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      grade,
      const DeepCollectionEquality().hash(_subjects),
      parentId,
      const DeepCollectionEquality().hash(_tutorIds),
      const DeepCollectionEquality().hash(_subjectProgress),
      createdAt);

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
      required final String name,
      required final String email,
      final String? grade,
      required final List<String> subjects,
      final String? parentId,
      required final List<String> tutorIds,
      required final Map<String, double> subjectProgress,
      required final DateTime createdAt}) = _$StudentProfileImpl;

  factory _StudentProfile.fromJson(Map<String, dynamic> json) =
      _$StudentProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String? get grade;
  @override
  List<String> get subjects;
  @override
  String? get parentId;
  @override
  List<String> get tutorIds;
  @override
  Map<String, double> get subjectProgress;
  @override
  DateTime get createdAt;

  /// Create a copy of StudentProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentProfileImplCopyWith<_$StudentProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
