import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/live_session.dart';

final liveSessionServiceProvider = Provider((ref) => LiveSessionService());

class LiveSessionService {
  final _supabase = Supabase.instance.client;

  Future<LiveSession> startSession(
    String sessionId,
    String tutorId,
    String studentId,
  ) async {
    try {
      final response = await _supabase
          .from('live_sessions')
          .insert({
            'session_id': sessionId,
            'tutor_id': tutorId,
            'student_id': studentId,
            'start_time': DateTime.now().toIso8601String(),
            'status': 'active',
            'participant_states': {tutorId: true, studentId: false},
            'active_participants': [tutorId],
          })
          .select()
          .single();

      return LiveSession.fromJson(response);
    } catch (e) {
      throw 'Failed to start live session: ${e.toString()}';
    }
  }

  Future<void> endSession(String liveSessionId) async {
    try {
      await _supabase
          .from('live_sessions')
          .update({
            'end_time': DateTime.now().toIso8601String(),
            'status': 'ended',
          })
          .eq('id', liveSessionId);
    } catch (e) {
      throw 'Failed to end live session: ${e.toString()}';
    }
  }

  Future<void> updateParticipantState(
    String liveSessionId,
    String participantId,
    bool isActive,
  ) async {
    try {
      final session = await _supabase
          .from('live_sessions')
          .select()
          .eq('id', liveSessionId)
          .single();

      Map<String, bool> participantStates = Map<String, bool>.from(
        session['participant_states'] as Map,
      );
      List<String> activeParticipants = List<String>.from(
        session['active_participants'] as List,
      );

      // Update participant state
      participantStates[participantId] = isActive;

      // Update active participants list
      if (isActive && !activeParticipants.contains(participantId)) {
        activeParticipants.add(participantId);
      } else if (!isActive) {
        activeParticipants.remove(participantId);
      }

      await _supabase
          .from('live_sessions')
          .update({
            'participant_states': participantStates,
            'active_participants': activeParticipants,
          })
          .eq('id', liveSessionId);
    } catch (e) {
      throw 'Failed to update participant state: ${e.toString()}';
    }
  }

  Future<void> updateWhiteboardData(
    String liveSessionId,
    String whiteboardData,
  ) async {
    try {
      await _supabase
          .from('live_sessions')
          .update({'whiteboard_data': whiteboardData})
          .eq('id', liveSessionId);
    } catch (e) {
      throw 'Failed to update whiteboard data: ${e.toString()}';
    }
  }

  Future<void> updateScreenShare(
    String liveSessionId,
    String? screenShareUrl,
  ) async {
    try {
      await _supabase
          .from('live_sessions')
          .update({'screen_share_url': screenShareUrl})
          .eq('id', liveSessionId);
    } catch (e) {
      throw 'Failed to update screen share: ${e.toString()}';
    }
  }

  Stream<LiveSession> streamLiveSession(String liveSessionId) {
    return _supabase
        .from('live_sessions')
        .stream(primaryKey: ['id'])
        .eq('id', liveSessionId)
        .map((response) => LiveSession.fromJson(response.first));
  }

  Future<LiveSession?> getCurrentLiveSession(String sessionId) async {
    try {
      final response = await _supabase
          .from('live_sessions')
          .select()
          .eq('session_id', sessionId)
          .eq('status', 'active')
          .maybeSingle();

      if (response == null) return null;
      return LiveSession.fromJson(response);
    } catch (e) {
      throw 'Failed to get current live session: ${e.toString()}';
    }
  }
}
