import 'package:flutter/foundation.dart';

enum LiveSessionStatus { waiting, active, ended, cancelled }

@immutable
class LiveSession {
  final String id;
  final String sessionId;
  final String tutorId;
  final String studentId;
  final DateTime startTime;
  final DateTime? endTime;
  final LiveSessionStatus status;
  final String? whiteboardData;
  final String? screenShareUrl;
  final Map<String, bool> participantStates;
  final List<String> activeParticipants;

  const LiveSession({
    required this.id,
    required this.sessionId,
    required this.tutorId,
    required this.studentId,
    required this.startTime,
    this.endTime,
    required this.status,
    this.whiteboardData,
    this.screenShareUrl,
    required this.participantStates,
    required this.activeParticipants,
  });

  LiveSession copyWith({
    String? id,
    String? sessionId,
    String? tutorId,
    String? studentId,
    DateTime? startTime,
    DateTime? endTime,
    LiveSessionStatus? status,
    String? whiteboardData,
    String? screenShareUrl,
    Map<String, bool>? participantStates,
    List<String>? activeParticipants,
  }) {
    return LiveSession(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      tutorId: tutorId ?? this.tutorId,
      studentId: studentId ?? this.studentId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      whiteboardData: whiteboardData ?? this.whiteboardData,
      screenShareUrl: screenShareUrl ?? this.screenShareUrl,
      participantStates: participantStates ?? this.participantStates,
      activeParticipants: activeParticipants ?? this.activeParticipants,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'session_id': sessionId,
      'tutor_id': tutorId,
      'student_id': studentId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'status': status.toString().split('.').last,
      'whiteboard_data': whiteboardData,
      'screen_share_url': screenShareUrl,
      'participant_states': participantStates,
      'active_participants': activeParticipants,
    };
  }

  factory LiveSession.fromJson(Map<String, dynamic> json) {
    return LiveSession(
      id: json['id'] as String,
      sessionId: json['session_id'] as String,
      tutorId: json['tutor_id'] as String,
      studentId: json['student_id'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] != null
          ? DateTime.parse(json['end_time'] as String)
          : null,
      status: LiveSessionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      whiteboardData: json['whiteboard_data'] as String?,
      screenShareUrl: json['screen_share_url'] as String?,
      participantStates: Map<String, bool>.from(
        json['participant_states'] as Map,
      ),
      activeParticipants: List<String>.from(
        json['active_participants'] as List,
      ),
    );
  }
}
