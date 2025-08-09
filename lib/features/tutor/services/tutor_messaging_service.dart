import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../messaging/models/chat_message.dart';

final tutorMessagingServiceProvider = Provider(
  (ref) => TutorMessagingService(),
);

class TutorMessagingService {
  final _supabase = Supabase.instance.client;

  Future<void> sendMessage(
    String tutorId,
    String studentId,
    String content, {
    String? attachmentUrl,
    String? attachmentType,
  }) async {
    try {
      await _supabase.from('chat_messages').insert({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'sender_id': tutorId,
        'receiver_id': studentId,
        'content': content,
        'timestamp': DateTime.now().toIso8601String(),
        'is_read': false,
        'attachment_url': attachmentUrl,
        'attachment_type': attachmentType,
      });
    } catch (e) {
      throw 'Failed to send message: ${e.toString()}';
    }
  }

  Stream<List<ChatMessage>> streamChatMessages(
    String tutorId,
    String studentId,
  ) {
    return _supabase
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .order('timestamp', ascending: true)
        .map((response) {
          return response
              .where(
                (record) =>
                    (record['sender_id'] == tutorId ||
                        record['receiver_id'] == tutorId) &&
                    (record['sender_id'] == studentId ||
                        record['receiver_id'] == studentId),
              )
              .map((json) => ChatMessage.fromJson(json))
              .toList();
        });
  }

  Stream<List<Map<String, dynamic>>> streamStudentChats(String tutorId) {
    return _supabase
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .order('timestamp', ascending: true)
        .map((response) {
          final messages = response.where(
            (record) =>
                record['sender_id'] == tutorId ||
                record['receiver_id'] == tutorId,
          );

          // Group messages by student
          final studentChats = <String, Map<String, dynamic>>{};
          for (final message in messages) {
            final studentId = message['sender_id'] == tutorId
                ? message['receiver_id']
                : message['sender_id'];

            if (!studentChats.containsKey(studentId)) {
              studentChats[studentId] = {
                'student_id': studentId,
                'last_message': message['content'],
                'last_message_time': message['timestamp'],
                'unread_count': 0,
              };
            }

            // Update unread count for incoming messages
            if (message['receiver_id'] == tutorId && !message['is_read']) {
              studentChats[studentId]!['unread_count'] =
                  (studentChats[studentId]!['unread_count'] ?? 0) + 1;
            }
          }
          return studentChats.values.toList()..sort(
            (a, b) => b['last_message_time'].compareTo(a['last_message_time']),
          );
        });
  }

  Future<void> markMessagesAsRead(String receiverId, String senderId) async {
    try {
      await _supabase
          .from('chat_messages')
          .update({'is_read': true})
          .eq('receiver_id', receiverId)
          .eq('sender_id', senderId)
          .eq('is_read', false);
    } catch (e) {
      throw 'Failed to mark messages as read: ${e.toString()}';
    }
  }

  Stream<int> streamUnreadMessageCount(String tutorId) {
    return _supabase
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .map(
          (response) => response
              .where(
                (record) =>
                    record['receiver_id'] == tutorId && !record['is_read'],
              )
              .length,
        );
  }
}
