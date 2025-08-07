import 'package:supabase_flutter/supabase_flutter.dart';
import 'base_service.dart';

class BillingService extends BaseService {
  BillingService(SupabaseClient supabase) : super(supabase, 'billing');

  Future<Map<String, dynamic>> createBilling({
    required String parentId,
    required String studentId,
    required double amount,
    required DateTime dueDate,
    String? invoiceUrl,
  }) async {
    try {
      return await create({
        'parent_id': parentId,
        'student_id': studentId,
        'amount': amount,
        'due_date': dueDate.toIso8601String(),
        'status': 'pending',
        'invoice_url': invoiceUrl,
      });
    } catch (e) {
      throw 'Failed to create billing: ${e.toString()}';
    }
  }

  Future<List<Map<String, dynamic>>> getBilling(String parentId) async {
    try {
      final response = await table
          .select('*, student:user_profiles(*)')
          .eq('parent_id', parentId)
          .order('due_date');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw 'Failed to get billing: ${e.toString()}';
    }
  }

  Future<Map<String, dynamic>> updateBillingStatus(
      String billingId, String status) async {
    try {
      return await update(billingId, {'status': status});
    } catch (e) {
      throw 'Failed to update billing status: ${e.toString()}';
    }
  }
}
