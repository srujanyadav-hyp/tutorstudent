import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/parent_dashboard_stats.dart';

class ParentDashboardService {
  final _supabase = Supabase.instance.client;

  Future<ParentDashboardStats> getParentStats(String parentId) async {
    try {
      // Get total number of linked students
      final students = await _supabase
          .from('students')
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
      if (e is PostgrestException) {
        throw 'Database error: ${e.message}';
      } else {
        throw 'Failed to get parent stats: ${e.toString()}';
      }
    }
  }

  Stream<List<Map<String, dynamic>>> streamLinkedStudents(String parentId) {
    return _supabase
        .from('students')
        .stream(primaryKey: ['id'])
        .eq('parent_id', parentId)
        .map(
          (students) => students.map((student) {
            final userId = student['id'] as String;
            return {
              'id': student['id'],
              'student': _supabase
                  .from('user_profiles')
                  .select()
                  .eq('id', userId)
                  .single(),
            };
          }).toList(),
        );
  }

  Future<void> linkStudent(String parentId, String studentEmail) async {
    try {
      await _supabase.rpc(
        'link_student',
        params: {'parent_uuid': parentId, 'student_email': studentEmail},
      );
    } catch (e) {
      if (e is PostgrestException) {
        throw e.message;
      } else {
        throw 'Failed to link student: ${e.toString()}';
      }
    }
  }

  Future<void> unlinkStudent(String parentId, String studentId) async {
    try {
      await _supabase.rpc(
        'unlink_student',
        params: {'parent_uuid': parentId, 'student_uuid': studentId},
      );
    } catch (e) {
      if (e is PostgrestException) {
        throw e.message;
      } else {
        throw 'Failed to unlink student: ${e.toString()}';
      }
    }
  }
}
