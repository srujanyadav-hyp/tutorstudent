import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_message.dart';

class MessagingService {
  final SupabaseClient _client = Supabase.instance.client;

  Stream<List<ChatMessage>> getChatMessages(String otherUserId) {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    final stream = _client
        .from('chats')
        .stream(primaryKey: ['id'])
        .order('created_at');

    return stream.map(
      (response) => response
          .where(
            (json) =>
                (json['sender_id'] == user.id &&
                    json['receiver_id'] == otherUserId) ||
                (json['sender_id'] == otherUserId &&
                    json['receiver_id'] == user.id),
          )
          .map((json) => ChatMessage.fromJson(json))
          .toList(),
    );
  }

  Future<ChatMessage> sendMessage({
    required String receiverId,
    required String message,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    final response = await _client
        .from('chats')
        .insert({
          'sender_id': user.id,
          'receiver_id': receiverId,
          'message': message,
        })
        .select()
        .single();

    return ChatMessage.fromJson(response);
  }

  Future<void> markAsRead(String messageId) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await _client
        .from('chats')
        .update({'is_read': true})
        .eq('id', messageId)
        .eq('receiver_id', user.id);
  }

  Stream<int> getUnreadCount() {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    return _client
        .from('chats')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map(
          (response) => response
              .where(
                (json) =>
                    json['receiver_id'] == user.id && json['is_read'] == false,
              )
              .length,
        );
  }
}
