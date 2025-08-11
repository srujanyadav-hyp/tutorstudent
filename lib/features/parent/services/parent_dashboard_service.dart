import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/parent_dashboard_stats.dart';

class ParentDashboardService {
  final _supabase = Supabase.instance.client;

  Future<ParentDashboardStats> getParentStats(String parentId) async {
    try {
      // Get total number of linked students
      final students = await _supabase
          .from('students')
          .select('id')
          .eq('parent_id', parentId);
      final studentsCount = students.length;

      // For now, return basic stats without complex queries that might fail
      return ParentDashboardStats(
        totalStudents: studentsCount,
        upcomingSessions:
            0, // TODO: Implement when class_sessions table is properly set up
        totalSpent:
            0.0, // TODO: Implement when billing table is properly set up
        pendingPayments:
            0, // TODO: Implement when billing table is properly set up
        recentActivities:
            [], // TODO: Implement when activity tracking is set up
      );
    } catch (e) {
      if (e is PostgrestException) {
        throw 'Database error: ${e.message}';
      } else {
        throw 'Failed to get parent stats: ${e.toString()}';
      }
    }
  }

  Future<List<Map<String, dynamic>>> getLinkedStudents(String parentId) async {
    try {
      // First get the student records
      final students = await _supabase
          .from('students')
          .select('id, grade, subjects, created_at')
          .eq('parent_id', parentId);

      // Then get the user profiles for each student
      final result = <Map<String, dynamic>>[];

      for (final student in students) {
        final userProfile = await _supabase
            .from('user_profiles')
            .select('id, full_name, email, profile_image')
            .eq('id', student['id'])
            .single();

        result.add({
          'id': student['id'],
          'student': {
            'id': userProfile['id'],
            'full_name': userProfile['full_name'] ?? 'Unknown Student',
            'grade': student['grade'],
            'profile_image': userProfile['profile_image'],
            'created_at': student['created_at'],
          },
        });
      }

      return result;
    } catch (e) {
      throw 'Failed to fetch linked students: ${e.toString()}';
    }
  }

  Future<void> linkStudent(String parentId, String studentEmail) async {
    try {
      // First, find the student by email
      final studentResponse = await _supabase
          .from('user_profiles')
          .select('id, role')
          .eq('email', studentEmail)
          .maybeSingle();

      if (studentResponse == null) {
        throw 'Student not found with this email';
      }

      if (studentResponse['role'] != 'student') {
        throw 'User is not a student';
      }

      final studentId = studentResponse['id'] as String;

      // Check if student record exists in students table
      final studentRecord = await _supabase
          .from('students')
          .select('id, parent_id')
          .eq('id', studentId)
          .maybeSingle();

      if (studentRecord == null) {
        // Create student record if it doesn't exist
        await _supabase.from('students').insert({
          'id': studentId,
          'parent_id': parentId,
        });
      } else {
        // Check if already linked to this parent
        if (studentRecord['parent_id'] == parentId) {
          throw 'Student is already linked to this parent';
        }

        // Update the parent_id
        await _supabase
            .from('students')
            .update({'parent_id': parentId})
            .eq('id', studentId);
      }
    } catch (e) {
      if (e is PostgrestException) {
        throw 'Database error: ${e.message}';
      } else {
        throw 'Failed to link student: ${e.toString()}';
      }
    }
  }

  Future<void> unlinkStudent(String parentId, String studentId) async {
    try {
      // Unlink the student by setting parent_id to null
      await _supabase
          .from('students')
          .update({'parent_id': null})
          .eq('id', studentId)
          .eq('parent_id', parentId);
    } catch (e) {
      if (e is PostgrestException) {
        throw e.message;
      } else {
        throw 'Failed to unlink student: ${e.toString()}';
      }
    }
  }
}
