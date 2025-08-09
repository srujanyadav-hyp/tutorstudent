// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'linked_student.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LinkedStudent _$LinkedStudentFromJson(Map<String, dynamic> json) {
  return _LinkedStudent.fromJson(json);
}

/// @nodoc
mixin _$LinkedStudent {
  String get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;

  /// Serializes this LinkedStudent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LinkedStudent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinkedStudentCopyWith<LinkedStudent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkedStudentCopyWith<$Res> {
  factory $LinkedStudentCopyWith(
          LinkedStudent value, $Res Function(LinkedStudent) then) =
      _$LinkedStudentCopyWithImpl<$Res, LinkedStudent>;
  @useResult
  $Res call(
      {String id,
      String fullName,
      String userId,
      DateTime createdAt,
      String? grade,
      String? profileImage});
}

/// @nodoc
class _$LinkedStudentCopyWithImpl<$Res, $Val extends LinkedStudent>
    implements $LinkedStudentCopyWith<$Res> {
  _$LinkedStudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LinkedStudent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? grade = freezed,
    Object? profileImage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinkedStudentImplCopyWith<$Res>
    implements $LinkedStudentCopyWith<$Res> {
  factory _$$LinkedStudentImplCopyWith(
          _$LinkedStudentImpl value, $Res Function(_$LinkedStudentImpl) then) =
      __$$LinkedStudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String fullName,
      String userId,
      DateTime createdAt,
      String? grade,
      String? profileImage});
}

/// @nodoc
class __$$LinkedStudentImplCopyWithImpl<$Res>
    extends _$LinkedStudentCopyWithImpl<$Res, _$LinkedStudentImpl>
    implements _$$LinkedStudentImplCopyWith<$Res> {
  __$$LinkedStudentImplCopyWithImpl(
      _$LinkedStudentImpl _value, $Res Function(_$LinkedStudentImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkedStudent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? grade = freezed,
    Object? profileImage = freezed,
  }) {
    return _then(_$LinkedStudentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LinkedStudentImpl implements _LinkedStudent {
  const _$LinkedStudentImpl(
      {required this.id,
      required this.fullName,
      required this.userId,
      required this.createdAt,
      this.grade,
      this.profileImage});

  factory _$LinkedStudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkedStudentImplFromJson(json);

  @override
  final String id;
  @override
  final String fullName;
  @override
  final String userId;
  @override
  final DateTime createdAt;
  @override
  final String? grade;
  @override
  final String? profileImage;

  @override
  String toString() {
    return 'LinkedStudent(id: $id, fullName: $fullName, userId: $userId, createdAt: $createdAt, grade: $grade, profileImage: $profileImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkedStudentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, fullName, userId, createdAt, grade, profileImage);

  /// Create a copy of LinkedStudent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkedStudentImplCopyWith<_$LinkedStudentImpl> get copyWith =>
      __$$LinkedStudentImplCopyWithImpl<_$LinkedStudentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkedStudentImplToJson(
      this,
    );
  }
}

abstract class _LinkedStudent implements LinkedStudent {
  const factory _LinkedStudent(
      {required final String id,
      required final String fullName,
      required final String userId,
      required final DateTime createdAt,
      final String? grade,
      final String? profileImage}) = _$LinkedStudentImpl;

  factory _LinkedStudent.fromJson(Map<String, dynamic> json) =
      _$LinkedStudentImpl.fromJson;

  @override
  String get id;
  @override
  String get fullName;
  @override
  String get userId;
  @override
  DateTime get createdAt;
  @override
  String? get grade;
  @override
  String? get profileImage;

  /// Create a copy of LinkedStudent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkedStudentImplCopyWith<_$LinkedStudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
