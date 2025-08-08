import 'package:flutter/foundation.dart';

@immutable
class TutorSession {
  final String id;
  final String tutorId;
  final String title;
  final String? description;
  final DateTime scheduledAt;
  final String? videoLink;
  final String status; // 'scheduled', 'ongoing', 'completed', 'cancelled'
  final List<String>? studentIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TutorSession({
    required this.id,
    required this.tutorId,
    required this.title,
    this.description,
    required this.scheduledAt,
    this.videoLink,
    required this.status,
    this.studentIds,
    required this.createdAt,
    required this.updatedAt,
  });

  TutorSession copyWith({
    String? title,
    String? description,
    DateTime? scheduledAt,
    String? videoLink,
    String? status,
    List<String>? studentIds,
  }) {
    return TutorSession(
      id: id,
      tutorId: tutorId,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      videoLink: videoLink ?? this.videoLink,
      status: status ?? this.status,
      studentIds: studentIds ?? this.studentIds,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  factory TutorSession.fromJson(Map<String, dynamic> json) {
    return TutorSession(
      id: json['id'] as String,
      tutorId: json['tutor_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      scheduledAt: DateTime.parse(json['scheduled_at'] as String),
      videoLink: json['video_link'] as String?,
      status: json['status'] as String,
      studentIds: json['student_ids'] != null
          ? List<String>.from(json['student_ids'] as List)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tutor_id': tutorId,
      'title': title,
      'description': description,
      'scheduled_at': scheduledAt.toIso8601String(),
      'video_link': videoLink,
      'status': status,
      'student_ids': studentIds,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TutorSession(id: $id, title: $title, scheduledAt: $scheduledAt, status: $status)';
  }
}
