// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_management.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ManagedStudentImpl _$$ManagedStudentImplFromJson(Map<String, dynamic> json) =>
    _$ManagedStudentImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      grade: json['grade'] as String?,
      subjects: json['subjects'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      lastSessionDate: json['lastSessionDate'] == null
          ? null
          : DateTime.parse(json['lastSessionDate'] as String),
      completedSessions: (json['completedSessions'] as num?)?.toInt() ?? 0,
      upcomingSessions: (json['upcomingSessions'] as num?)?.toInt() ?? 0,
      averagePerformance:
          (json['averagePerformance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$ManagedStudentImplToJson(
        _$ManagedStudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'grade': instance.grade,
      'subjects': instance.subjects,
      'isActive': instance.isActive,
      'lastSessionDate': instance.lastSessionDate?.toIso8601String(),
      'completedSessions': instance.completedSessions,
      'upcomingSessions': instance.upcomingSessions,
      'averagePerformance': instance.averagePerformance,
    };

_$StudentProgressImpl _$$StudentProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$StudentProgressImpl(
      studentId: json['studentId'] as String,
      sessionHistory: (json['sessionHistory'] as List<dynamic>?)
              ?.map(
                  (e) => SessionAttendance.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      assignments: (json['assignments'] as List<dynamic>?)
              ?.map(
                  (e) => AssignmentProgress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subjectPerformance:
          (json['subjectPerformance'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
    );

Map<String, dynamic> _$$StudentProgressImplToJson(
        _$StudentProgressImpl instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'sessionHistory': instance.sessionHistory,
      'assignments': instance.assignments,
      'subjectPerformance': instance.subjectPerformance,
    };

_$SessionAttendanceImpl _$$SessionAttendanceImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionAttendanceImpl(
      sessionId: json['sessionId'] as String,
      date: DateTime.parse(json['date'] as String),
      attended: json['attended'] as bool,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$SessionAttendanceImplToJson(
        _$SessionAttendanceImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'date': instance.date.toIso8601String(),
      'attended': instance.attended,
      'notes': instance.notes,
    };

_$AssignmentProgressImpl _$$AssignmentProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$AssignmentProgressImpl(
      assignmentId: json['assignmentId'] as String,
      title: json['title'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      completed: json['completed'] as bool? ?? false,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      feedback: json['feedback'] as String?,
    );

Map<String, dynamic> _$$AssignmentProgressImplToJson(
        _$AssignmentProgressImpl instance) =>
    <String, dynamic>{
      'assignmentId': instance.assignmentId,
      'title': instance.title,
      'dueDate': instance.dueDate.toIso8601String(),
      'completed': instance.completed,
      'score': instance.score,
      'feedback': instance.feedback,
    };
