import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/chat_message.dart';

class MessagingService {
  final SupabaseClient _client = Supabase.instance.client;

  Stream<List<ChatMessage>> getChatMessages(String otherUserId) {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    return _client
        .from('chats')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .select()
        .or('sender_id.eq.${user.id},receiver_id.eq.${user.id}')
        .and('sender_id.eq.$otherUserId,receiver_id.eq.$otherUserId')
        .map((response) => response
            .map((json) => ChatMessage.fromJson(json as Map<String, dynamic>))
            .toList());
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

    return ChatMessage.fromJson(response as Map<String, dynamic>);
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
        .eq('receiver_id', user.id)
        .eq('is_read', false)
        .map((response) => response.length);
  }
}
