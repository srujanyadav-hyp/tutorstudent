// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TutorModel _$TutorModelFromJson(Map<String, dynamic> json) {
  return _TutorModel.fromJson(json);
}

/// @nodoc
mixin _$TutorModel {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String? get expertise => throw _privateConstructorUsedError;
  String? get qualifications => throw _privateConstructorUsedError;
  @JsonKey(name: 'experience_years')
  int? get experienceYears => throw _privateConstructorUsedError;
  double? get pricing => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this TutorModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TutorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TutorModelCopyWith<TutorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TutorModelCopyWith<$Res> {
  factory $TutorModelCopyWith(
          TutorModel value, $Res Function(TutorModel) then) =
      _$TutorModelCopyWithImpl<$Res, TutorModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      String? expertise,
      String? qualifications,
      @JsonKey(name: 'experience_years') int? experienceYears,
      double? pricing,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$TutorModelCopyWithImpl<$Res, $Val extends TutorModel>
    implements $TutorModelCopyWith<$Res> {
  _$TutorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TutorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? expertise = freezed,
    Object? qualifications = freezed,
    Object? experienceYears = freezed,
    Object? pricing = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      expertise: freezed == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as String?,
      qualifications: freezed == qualifications
          ? _value.qualifications
          : qualifications // ignore: cast_nullable_to_non_nullable
              as String?,
      experienceYears: freezed == experienceYears
          ? _value.experienceYears
          : experienceYears // ignore: cast_nullable_to_non_nullable
              as int?,
      pricing: freezed == pricing
          ? _value.pricing
          : pricing // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TutorModelImplCopyWith<$Res>
    implements $TutorModelCopyWith<$Res> {
  factory _$$TutorModelImplCopyWith(
          _$TutorModelImpl value, $Res Function(_$TutorModelImpl) then) =
      __$$TutorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      String? expertise,
      String? qualifications,
      @JsonKey(name: 'experience_years') int? experienceYears,
      double? pricing,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$TutorModelImplCopyWithImpl<$Res>
    extends _$TutorModelCopyWithImpl<$Res, _$TutorModelImpl>
    implements _$$TutorModelImplCopyWith<$Res> {
  __$$TutorModelImplCopyWithImpl(
      _$TutorModelImpl _value, $Res Function(_$TutorModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TutorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? expertise = freezed,
    Object? qualifications = freezed,
    Object? experienceYears = freezed,
    Object? pricing = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$TutorModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      expertise: freezed == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as String?,
      qualifications: freezed == qualifications
          ? _value.qualifications
          : qualifications // ignore: cast_nullable_to_non_nullable
              as String?,
      experienceYears: freezed == experienceYears
          ? _value.experienceYears
          : experienceYears // ignore: cast_nullable_to_non_nullable
              as int?,
      pricing: freezed == pricing
          ? _value.pricing
          : pricing // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TutorModelImpl implements _TutorModel {
  const _$TutorModelImpl(
      {@JsonKey(name: 'user_id') required this.userId,
      this.expertise,
      this.qualifications,
      @JsonKey(name: 'experience_years') this.experienceYears,
      this.pricing,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$TutorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TutorModelImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String? expertise;
  @override
  final String? qualifications;
  @override
  @JsonKey(name: 'experience_years')
  final int? experienceYears;
  @override
  final double? pricing;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'TutorModel(userId: $userId, expertise: $expertise, qualifications: $qualifications, experienceYears: $experienceYears, pricing: $pricing, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TutorModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.expertise, expertise) ||
                other.expertise == expertise) &&
            (identical(other.qualifications, qualifications) ||
                other.qualifications == qualifications) &&
            (identical(other.experienceYears, experienceYears) ||
                other.experienceYears == experienceYears) &&
            (identical(other.pricing, pricing) || other.pricing == pricing) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, expertise,
      qualifications, experienceYears, pricing, createdAt);

  /// Create a copy of TutorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TutorModelImplCopyWith<_$TutorModelImpl> get copyWith =>
      __$$TutorModelImplCopyWithImpl<_$TutorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TutorModelImplToJson(
      this,
    );
  }
}

abstract class _TutorModel implements TutorModel {
  const factory _TutorModel(
          {@JsonKey(name: 'user_id') required final String userId,
          final String? expertise,
          final String? qualifications,
          @JsonKey(name: 'experience_years') final int? experienceYears,
          final double? pricing,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$TutorModelImpl;

  factory _TutorModel.fromJson(Map<String, dynamic> json) =
      _$TutorModelImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String? get expertise;
  @override
  String? get qualifications;
  @override
  @JsonKey(name: 'experience_years')
  int? get experienceYears;
  @override
  double? get pricing;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of TutorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TutorModelImplCopyWith<_$TutorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
