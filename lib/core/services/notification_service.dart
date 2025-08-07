import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/notification.dart' as app_notification;
import 'base_service.dart';

class NotificationService extends BaseService {
  NotificationService(SupabaseClient client) : super(client, 'notifications');

  Future<List<app_notification.Notification>> getUserNotifications(
      String userId) async {
    final response = await table
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return response
        .map((json) => app_notification.Notification.fromJson(json))
        .toList();
  }

  Future<List<app_notification.Notification>> getUnreadNotifications(
      String userId) async {
    final response = await table
        .select()
        .eq('user_id', userId)
        .eq('read', false)
        .order('created_at', ascending: false);
    return response
        .map((json) => app_notification.Notification.fromJson(json))
        .toList();
  }

  Future<void> markAsRead(String notificationId) async {
    await table.update({'read': true}).eq('id', notificationId);
  }

  Future<void> markAllAsRead(String userId) async {
    await table.update({'read': true}).eq('user_id', userId).eq('read', false);
  }

  Future<app_notification.Notification> createNotification({
    required String userId,
    required String title,
    required String body,
  }) async {
    final response = await table
        .insert({
          'user_id': userId,
          'title': title,
          'body': body,
          'read': false,
        })
        .select()
        .single();
    return app_notification.Notification.fromJson(response);
  }
}
