import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/parent_dashboard_stats.dart';

class ParentDashboardService {
  final _supabase = Supabase.instance.client;

  Future<ParentDashboardStats> getParentStats(String parentId) async {
    try {
      // Get total number of linked students
      final students = await _supabase
          .from('parent_student_links')
          .select()
          .eq('parent_id', parentId);
      final studentsCount = students.length;

      // Get upcoming sessions for all linked students
      final upcomingSessions = await _supabase.rpc(
        'get_parent_upcoming_sessions',
        params: {'p_parent_id': parentId},
      );

      // Get total spending and pending payments
      final billingStats = await _supabase.rpc(
        'get_parent_billing_stats',
        params: {'p_parent_id': parentId},
      );

      // Get recent activities
      final recentActivities =
          await _supabase.rpc(
                'get_parent_recent_activities',
                params: {'p_parent_id': parentId},
              )
              as List<dynamic>;

      return ParentDashboardStats(
        totalStudents: studentsCount,
        upcomingSessions: (upcomingSessions as List).length,
        totalSpent: (billingStats['total_spent'] as num).toDouble(),
        pendingPayments: billingStats['pending_payments'] as int,
        recentActivities: recentActivities.cast<Map<String, dynamic>>(),
      );
    } catch (e) {
      throw 'Failed to get parent stats: ${e.toString()}';
    }
  }

  Stream<List<Map<String, dynamic>>> streamLinkedStudents(String parentId) {
    return _supabase
        .from('parent_student_links')
        .stream(primaryKey: ['id'])
        .eq('parent_id', parentId)
        .map(
          (records) => records.map((record) {
            final studentId = record['student_id'] as String;
            return {
              'id': studentId,
              'student': _supabase
                  .from('user_profiles')
                  .select()
                  .eq('id', studentId)
                  .single(),
            };
          }).toList(),
        );
  }

  Future<void> linkStudent(String parentId, String studentId) async {
    try {
      await _supabase.from('parent_student_links').insert({
        'parent_id': parentId,
        'student_id': studentId,
      });
    } catch (e) {
      throw 'Failed to link student: ${e.toString()}';
    }
  }

  Future<void> unlinkStudent(String parentId, String studentId) async {
    try {
      await _supabase
          .from('parent_student_links')
          .delete()
          .eq('parent_id', parentId)
          .eq('student_id', studentId);
    } catch (e) {
      throw 'Failed to unlink student: ${e.toString()}';
    }
  }
}
