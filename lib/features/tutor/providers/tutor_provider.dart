import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../models/tutor_dashboard_stats.dart';

final tutorStatsProvider = FutureProvider.family<TutorDashboardStats, String>(
  (ref, tutorId) async {
    final supabase = ref.read(supabaseServiceProvider);
    
    // Fetch tutor statistics from Supabase
    final sessionsResponse = await supabase.client
        .from('sessions')
        .select('*')
        .eq('tutor_id', tutorId)
        .gte('created_at', DateTime.now().subtract(const Duration(days: 30)).toIso8601String());
    
    final studentsResponse = await supabase.client
        .from('student_tutor_relationships')
        .select('*')
        .eq('tutor_id', tutorId);
    
    final ratingsResponse = await supabase.client
        .from('session_ratings')
        .select('rating')
        .eq('tutor_id', tutorId);
    
    // Calculate statistics
    final totalSessions = sessionsResponse.length;
    final totalStudents = studentsResponse.length;
    final activeStudents = studentsResponse.where((s) => s['status'] == 'active').length;
    
    double totalEarnings = 0.0;
    for (final session in sessionsResponse) {
      if (session['status'] == 'completed') {
        totalEarnings += (session['price'] ?? 0.0);
      }
    }
    
    double averageRating = 0.0;
    if (ratingsResponse.isNotEmpty) {
      final totalRating = ratingsResponse.fold<double>(
        0.0,
        (sum, rating) => sum + (rating['rating'] ?? 0.0),
      );
      averageRating = totalRating / ratingsResponse.length;
    }
    
    // Generate sample performance trend (replace with actual data)
    final performanceTrend = List.generate(7, (index) {
      return (index * 0.1 + 0.5).clamp(0.0, 1.0);
    });
    
    return TutorDashboardStats(
      totalSessions: totalSessions,
      activeStudents: activeStudents,
      totalEarnings: totalEarnings,
      averageRating: averageRating,
      performanceTrend: performanceTrend,
      totalStudents: totalStudents,
    );
  },
);

final tutorUpcomingSessionsProvider = FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, tutorId) async {
    final supabase = ref.read(supabaseServiceProvider);
    
    final response = await supabase.client
        .from('sessions')
        .select('*, students(name)')
        .eq('tutor_id', tutorId)
        .eq('status', 'scheduled')
        .gte('scheduled_at', DateTime.now().toIso8601String())
        .order('scheduled_at')
        .limit(5);
    
    return response.map((session) {
      final student = session['students'] as Map<String, dynamic>?;
      return {
        'id': session['id'],
        'student_name': student?['name'] ?? 'Unknown Student',
        'subject': session['subject'],
        'date': session['scheduled_at'],
        'duration': session['duration'],
        'status': session['status'],
      };
    }).toList();
  },
);

final recentStudentsProvider = FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, tutorId) async {
    final supabase = ref.read(supabaseServiceProvider);
    
    final response = await supabase.client
        .from('student_tutor_relationships')
        .select('*, students(name, subjects)')
        .eq('tutor_id', tutorId)
        .order('created_at', ascending: false)
        .limit(5);
    
    return response.map((relationship) {
      final student = relationship['students'] as Map<String, dynamic>?;
      return {
        'id': relationship['id'],
        'name': student?['name'] ?? 'Unknown Student',
        'subject': student?['subjects']?.first ?? 'General',
        'rating': 4.5, // Replace with actual rating
        'sessions_count': 3, // Replace with actual count
        'status': relationship['status'],
      };
    }).toList();
  },
);
