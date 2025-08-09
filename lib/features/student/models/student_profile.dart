import 'package:flutter/foundation.dart';

@immutable
class StudentProfile {
  final String id;
  final String name;
  final String email;
  final String? grade;
  final List<String> subjects;
  final String? parentId;
  final List<String> tutorIds;
  final Map<String, double> subjectProgress;
  final DateTime createdAt;

  const StudentProfile({
    required this.id,
    required this.name,
    required this.email,
    this.grade,
    required this.subjects,
    this.parentId,
    required this.tutorIds,
    required this.subjectProgress,
    required this.createdAt,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      grade: json['grade'] as String?,
      subjects: List<String>.from(json['subjects'] as List),
      parentId: json['parent_id'] as String?,
      tutorIds: List<String>.from(json['tutor_ids'] as List),
      subjectProgress: Map<String, double>.from(
        json['subject_progress'] as Map,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'grade': grade,
      'subjects': subjects,
      'parent_id': parentId,
      'tutor_ids': tutorIds,
      'subject_progress': subjectProgress,
      'created_at': createdAt.toIso8601String(),
    };
  }

  StudentProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? grade,
    List<String>? subjects,
    String? parentId,
    List<String>? tutorIds,
    Map<String, double>? subjectProgress,
    DateTime? createdAt,
  }) {
    return StudentProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      grade: grade ?? this.grade,
      subjects: subjects ?? this.subjects,
      parentId: parentId ?? this.parentId,
      tutorIds: tutorIds ?? this.tutorIds,
      subjectProgress: subjectProgress ?? this.subjectProgress,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
