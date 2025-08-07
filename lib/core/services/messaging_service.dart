import 'package:supabase_flutter/supabase_flutter.dart';
import 'base_service.dart';

class MessagingService extends BaseService {
  MessagingService(SupabaseClient supabase) : super(supabase, 'messages');

  Future<Map<String, dynamic>> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    try {
      return await create({
        'sender_id': senderId,
        'receiver_id': receiverId,
        'message': message,
      });
    } catch (e) {
      throw 'Failed to send message: ${e.toString()}';
    }
  }

  Future<List<Map<String, dynamic>>> getMessages(String userId) async {
    try {
      final response = await table
          .select('*, sender:user_profiles(*), receiver:user_profiles(*)')
          .or('sender_id.eq.$userId,receiver_id.eq.$userId')
          .order('sent_at');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw 'Failed to get messages: ${e.toString()}';
    }
  }

  Stream<List<Map<String, dynamic>>> subscribeToMessages(String userId) {
    return table
        .stream(primaryKey: ['id'])
        .eq('sender_id', userId)
        .map((data) => List<Map<String, dynamic>>.from(data));
  }

  Future<List<Map<String, dynamic>>> getUnreadMessages(String userId) async {
    try {
      final response = await table
          .select('*, sender:user_profiles(*)')
          .eq('receiver_id', userId)
          .eq('read', false)
          .order('sent_at');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw 'Failed to get unread messages: ${e.toString()}';
    }
  }

  Future<void> markMessageAsRead(String messageId) async {
    try {
      await update(messageId, {'read': true});
    } catch (e) {
      throw 'Failed to mark message as read: ${e.toString()}';
    }
  }
}
