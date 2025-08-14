import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';

// Provider for managing session data
final sessionsProvider = FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, userId) async {
    final supabase = ref.read(supabaseServiceProvider);
    
    try {
      final response = await supabase.client
          .from('sessions')
          .select('*')
          .eq('student_id', userId)
          .order('scheduled_at', ascending: true);
      
      return response;
    } catch (e) {
      // Return sample data for development
      return _getSampleSessions();
    }
  },
);

// Provider for upcoming sessions
final upcomingSessionsProvider = FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, userId) async {
    final supabase = ref.read(supabaseServiceProvider);
    
    try {
      final response = await supabase.client
          .from('sessions')
          .select('*')
          .eq('student_id', userId)
          .eq('status', 'scheduled')
          .gte('scheduled_at', DateTime.now().toIso8601String())
          .order('scheduled_at')
          .limit(5);
      
      return response;
    } catch (e) {
      // Return sample data for development
      return _getSampleSessions().where((session) => 
        session['status'] == 'scheduled'
      ).toList();
    }
  },
);

List<Map<String, dynamic>> _getSampleSessions() {
  return [
    {
      'id': '1',
      'tutor_name': 'Dr. Sarah Johnson',
      'subject': 'Mathematics',
      'scheduled_at': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
      'duration': '1 hour',
      'status': 'scheduled',
      'price': 45.0,
    },
    {
      'id': '2',
      'tutor_name': 'Prof. Michael Chen',
      'subject': 'Physics',
      'scheduled_at': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
      'duration': '1.5 hours',
      'status': 'scheduled',
      'price': 55.0,
    },
    {
      'id': '3',
      'tutor_name': 'Emma Rodriguez',
      'subject': 'English',
      'scheduled_at': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      'duration': '1 hour',
      'status': 'completed',
      'price': 35.0,
    },
  ];
}
