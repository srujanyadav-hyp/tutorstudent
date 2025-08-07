import 'package:supabase_flutter/supabase_flutter.dart';
import 'base_service.dart';

class LearningInsightsService extends BaseService {
  LearningInsightsService(SupabaseClient supabase)
      : super(supabase, 'learning_insights');

  Future<Map<String, dynamic>> recordInsight({
    required String studentId,
    required String insightType,
    required Map<String, dynamic> value,
  }) async {
    try {
      return await create({
        'student_id': studentId,
        'insight_type': insightType,
        'value': value,
      });
    } catch (e) {
      throw 'Failed to record learning insight: ${e.toString()}';
    }
  }

  Future<List<Map<String, dynamic>>> getInsights(String studentId,
      {String? type}) async {
    try {
      var query = table.select().eq('student_id', studentId);

      if (type != null) {
        query = query.eq('insight_type', type);
      }

      final response = await query.order('created_at');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw 'Failed to get learning insights: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> getLatestInsight(
      String studentId, String type) async {
    try {
      final response = await table
          .select()
          .eq('student_id', studentId)
          .eq('insight_type', type)
          .order('created_at', ascending: false)
          .limit(1)
          .single();

      return response;
    } catch (e) {
      throw 'Failed to get latest learning insight: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> updateInsight(
      String insightId, Map<String, dynamic> value) async {
    try {
      return await update(insightId, {'value': value});
    } catch (e) {
      throw 'Failed to update learning insight: ${e.toString()}';
    }
  }
}
