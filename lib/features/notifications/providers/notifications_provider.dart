import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/supabase_service.dart';

class NotificationsNotifier
    extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  final _supabase = SupabaseService();

  NotificationsNotifier() : super(const AsyncValue.loading()) {
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      state = const AsyncValue.loading();

      // Get current user
      final user = _supabase.client.auth.currentUser;
      if (user == null) {
        state = const AsyncValue.data([]);
        return;
      }

      // Load notifications from Supabase
      final response = await _supabase.client
          .from('notifications')
          .select('*')
          .eq('user_id', user.id)
          .order('created_at', ascending: false)
          .limit(50);

      state = AsyncValue.data(response);
    } catch (e) {
      // Return sample data for development
      state = AsyncValue.data(_getSampleNotifications());
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final user = _supabase.client.auth.currentUser;
      if (user == null) return;

      await _supabase.client
          .from('notifications')
          .update({'is_read': true})
          .eq('id', notificationId)
          .eq('user_id', user.id);

      // Update local state
      final currentNotifications = state.value ?? [];
      final updatedNotifications = currentNotifications.map((notification) {
        if (notification['id'] == notificationId) {
          return {...notification, 'is_read': true};
        }
        return notification;
      }).toList();

      state = AsyncValue.data(updatedNotifications);
    } catch (e) {
      // Handle error silently for now
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final user = _supabase.client.auth.currentUser;
      if (user == null) return;

      await _supabase.client
          .from('notifications')
          .update({'is_read': true})
          .eq('user_id', user.id);

      // Update local state
      final currentNotifications = state.value ?? [];
      final updatedNotifications = currentNotifications.map((notification) {
        return {...notification, 'is_read': true};
      }).toList();

      state = AsyncValue.data(updatedNotifications);
    } catch (e) {
      // Handle error silently for now
    }
  }

  Future<void> refresh() async {
    await _loadNotifications();
  }

  List<Map<String, dynamic>> _getSampleNotifications() {
    return [
      {
        'id': '1',
        'type': 'session_reminder',
        'title': 'Session Reminder',
        'message':
            'Your math session with Dr. Sarah Johnson starts in 30 minutes',
        'is_read': false,
        'created_at': DateTime.now()
            .subtract(const Duration(minutes: 30))
            .toIso8601String(),
        'data': {'session_id': '123'},
      },
      {
        'id': '2',
        'type': 'assignment_due',
        'title': 'Assignment Due Soon',
        'message': 'Your calculus homework is due tomorrow',
        'is_read': false,
        'created_at': DateTime.now()
            .subtract(const Duration(hours: 2))
            .toIso8601String(),
        'data': {'assignment_id': '456'},
      },
      {
        'id': '3',
        'type': 'new_message',
        'title': 'New Message',
        'message':
            'Dr. Sarah Johnson sent you a message about your next session',
        'is_read': true,
        'created_at': DateTime.now()
            .subtract(const Duration(hours: 4))
            .toIso8601String(),
        'data': {'message_id': '789'},
      },
      {
        'id': '4',
        'type': 'payment_success',
        'title': 'Payment Successful',
        'message':
            'Your payment of \$45 for the math session has been processed',
        'is_read': true,
        'created_at': DateTime.now()
            .subtract(const Duration(days: 1))
            .toIso8601String(),
        'data': {'payment_id': '101'},
      },
      {
        'id': '5',
        'type': 'tutor_available',
        'title': 'Tutor Available',
        'message': 'Prof. Michael Chen is now available for physics sessions',
        'is_read': true,
        'created_at': DateTime.now()
            .subtract(const Duration(days: 2))
            .toIso8601String(),
        'data': {'tutor_id': '202'},
      },
    ];
  }
}

final notificationsProvider =
    StateNotifierProvider<
      NotificationsNotifier,
      AsyncValue<List<Map<String, dynamic>>>
    >((ref) => NotificationsNotifier());
