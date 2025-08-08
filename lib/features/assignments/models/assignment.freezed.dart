// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assignment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Assignment _$AssignmentFromJson(Map<String, dynamic> json) {
  return _Assignment.fromJson(json);
}

/// @nodoc
mixin _$Assignment {
  String get id => throw _privateConstructorUsedError;
  String get tutorId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssignmentCopyWith<Assignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentCopyWith<$Res> {
  factory $AssignmentCopyWith(
          Assignment value, $Res Function(Assignment) then) =
      _$AssignmentCopyWithImpl<$Res, Assignment>;
  @useResult
  $Res call(
      {String id,
      String tutorId,
      String title,
      String? description,
      DateTime dueDate,
      DateTime createdAt});
}

/// @nodoc
class _$AssignmentCopyWithImpl<$Res, $Val extends Assignment>
    implements $AssignmentCopyWith<$Res> {
  _$AssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tutorId = null,
    Object? title = null,
    Object? description = freezed,
    Object? dueDate = null,
    Object? createdAt = null,
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
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssignmentImplCopyWith<$Res>
    implements $AssignmentCopyWith<$Res> {
  factory _$$AssignmentImplCopyWith(
          _$AssignmentImpl value, $Res Function(_$AssignmentImpl) then) =
      __$$AssignmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String tutorId,
      String title,
      String? description,
      DateTime dueDate,
      DateTime createdAt});
}

/// @nodoc
class __$$AssignmentImplCopyWithImpl<$Res>
    extends _$AssignmentCopyWithImpl<$Res, _$AssignmentImpl>
    implements _$$AssignmentImplCopyWith<$Res> {
  __$$AssignmentImplCopyWithImpl(
      _$AssignmentImpl _value, $Res Function(_$AssignmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tutorId = null,
    Object? title = null,
    Object? description = freezed,
    Object? dueDate = null,
    Object? createdAt = null,
  }) {
    return _then(_$AssignmentImpl(
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
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentImpl implements _Assignment {
  const _$AssignmentImpl(
      {required this.id,
      required this.tutorId,
      required this.title,
      this.description,
      required this.dueDate,
      required this.createdAt});

  factory _$AssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentImplFromJson(json);

  @override
  final String id;
  @override
  final String tutorId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime dueDate;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Assignment(id: $id, tutorId: $tutorId, title: $title, description: $description, dueDate: $dueDate, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tutorId, tutorId) || other.tutorId == tutorId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, tutorId, title, description, dueDate, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentImplCopyWith<_$AssignmentImpl> get copyWith =>
      __$$AssignmentImplCopyWithImpl<_$AssignmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentImplToJson(
      this,
    );
  }
}

abstract class _Assignment implements Assignment {
  const factory _Assignment(
      {required final String id,
      required final String tutorId,
      required final String title,
      final String? description,
      required final DateTime dueDate,
      required final DateTime createdAt}) = _$AssignmentImpl;

  factory _Assignment.fromJson(Map<String, dynamic> json) =
      _$AssignmentImpl.fromJson;

  @override
  String get id;
  @override
  String get tutorId;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get dueDate;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AssignmentImplCopyWith<_$AssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssignmentSubmission _$AssignmentSubmissionFromJson(Map<String, dynamic> json) {
  return _AssignmentSubmission.fromJson(json);
}

/// @nodoc
mixin _$AssignmentSubmission {
  String get id => throw _privateConstructorUsedError;
  String get assignmentId => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String? get submissionFile => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;
  String? get feedback => throw _privateConstructorUsedError;
  DateTime get submittedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssignmentSubmissionCopyWith<AssignmentSubmission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentSubmissionCopyWith<$Res> {
  factory $AssignmentSubmissionCopyWith(AssignmentSubmission value,
          $Res Function(AssignmentSubmission) then) =
      _$AssignmentSubmissionCopyWithImpl<$Res, AssignmentSubmission>;
  @useResult
  $Res call(
      {String id,
      String assignmentId,
      String studentId,
      String? submissionFile,
      String? grade,
      String? feedback,
      DateTime submittedAt});
}

/// @nodoc
class _$AssignmentSubmissionCopyWithImpl<$Res,
        $Val extends AssignmentSubmission>
    implements $AssignmentSubmissionCopyWith<$Res> {
  _$AssignmentSubmissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assignmentId = null,
    Object? studentId = null,
    Object? submissionFile = freezed,
    Object? grade = freezed,
    Object? feedback = freezed,
    Object? submittedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      submissionFile: freezed == submissionFile
          ? _value.submissionFile
          : submissionFile // ignore: cast_nullable_to_non_nullable
              as String?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssignmentSubmissionImplCopyWith<$Res>
    implements $AssignmentSubmissionCopyWith<$Res> {
  factory _$$AssignmentSubmissionImplCopyWith(_$AssignmentSubmissionImpl value,
          $Res Function(_$AssignmentSubmissionImpl) then) =
      __$$AssignmentSubmissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String assignmentId,
      String studentId,
      String? submissionFile,
      String? grade,
      String? feedback,
      DateTime submittedAt});
}

/// @nodoc
class __$$AssignmentSubmissionImplCopyWithImpl<$Res>
    extends _$AssignmentSubmissionCopyWithImpl<$Res, _$AssignmentSubmissionImpl>
    implements _$$AssignmentSubmissionImplCopyWith<$Res> {
  __$$AssignmentSubmissionImplCopyWithImpl(_$AssignmentSubmissionImpl _value,
      $Res Function(_$AssignmentSubmissionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assignmentId = null,
    Object? studentId = null,
    Object? submissionFile = freezed,
    Object? grade = freezed,
    Object? feedback = freezed,
    Object? submittedAt = null,
  }) {
    return _then(_$AssignmentSubmissionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      submissionFile: freezed == submissionFile
          ? _value.submissionFile
          : submissionFile // ignore: cast_nullable_to_non_nullable
              as String?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentSubmissionImpl implements _AssignmentSubmission {
  const _$AssignmentSubmissionImpl(
      {required this.id,
      required this.assignmentId,
      required this.studentId,
      this.submissionFile,
      this.grade,
      this.feedback,
      required this.submittedAt});

  factory _$AssignmentSubmissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentSubmissionImplFromJson(json);

  @override
  final String id;
  @override
  final String assignmentId;
  @override
  final String studentId;
  @override
  final String? submissionFile;
  @override
  final String? grade;
  @override
  final String? feedback;
  @override
  final DateTime submittedAt;

  @override
  String toString() {
    return 'AssignmentSubmission(id: $id, assignmentId: $assignmentId, studentId: $studentId, submissionFile: $submissionFile, grade: $grade, feedback: $feedback, submittedAt: $submittedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentSubmissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.submissionFile, submissionFile) ||
                other.submissionFile == submissionFile) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, assignmentId, studentId,
      submissionFile, grade, feedback, submittedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentSubmissionImplCopyWith<_$AssignmentSubmissionImpl>
      get copyWith =>
          __$$AssignmentSubmissionImplCopyWithImpl<_$AssignmentSubmissionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentSubmissionImplToJson(
      this,
    );
  }
}

abstract class _AssignmentSubmission implements AssignmentSubmission {
  const factory _AssignmentSubmission(
      {required final String id,
      required final String assignmentId,
      required final String studentId,
      final String? submissionFile,
      final String? grade,
      final String? feedback,
      required final DateTime submittedAt}) = _$AssignmentSubmissionImpl;

  factory _AssignmentSubmission.fromJson(Map<String, dynamic> json) =
      _$AssignmentSubmissionImpl.fromJson;

  @override
  String get id;
  @override
  String get assignmentId;
  @override
  String get studentId;
  @override
  String? get submissionFile;
  @override
  String? get grade;
  @override
  String? get feedback;
  @override
  DateTime get submittedAt;
  @override
  @JsonKey(ignore: true)
  _$$AssignmentSubmissionImplCopyWith<_$AssignmentSubmissionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
