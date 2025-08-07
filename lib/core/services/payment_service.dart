import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/payment.dart';
import 'base_service.dart';

class PaymentService extends BaseService {
  PaymentService(SupabaseClient client) : super(client, 'payments');

  Future<List<Payment>> getUserPayments(String userId) async {
    final response = await table
        .select()
        .or('student_id.eq.$userId,tutor_id.eq.$userId')
        .order('payment_date', ascending: false);
    return response.map((json) => Payment.fromJson(json)).toList();
  }

  Future<List<Payment>> getTutorPayments(String tutorId) async {
    final response = await table
        .select()
        .eq('tutor_id', tutorId)
        .order('payment_date', ascending: false);
    return response.map((json) => Payment.fromJson(json)).toList();
  }

  Future<List<Payment>> getStudentPayments(String studentId) async {
    final response = await table
        .select()
        .eq('student_id', studentId)
        .order('payment_date', ascending: false);
    return response.map((json) => Payment.fromJson(json)).toList();
  }

  Future<Payment> createPayment({
    required String studentId,
    required String tutorId,
    String? sessionId,
    required double amount,
    String currency = 'INR',
    String? paymentMethod,
  }) async {
    final response = await table
        .insert({
          'student_id': studentId,
          'tutor_id': tutorId,
          'session_id': sessionId,
          'amount': amount,
          'currency': currency,
          'status': PaymentStatus.pending.toString().split('.').last,
          'payment_method': paymentMethod,
          'payment_date': DateTime.now().toIso8601String(),
        })
        .select()
        .single();
    return Payment.fromJson(response);
  }

  Future<void> updatePaymentStatus(
      String paymentId, PaymentStatus status) async {
    await table.update({
      'status': status.toString().split('.').last,
    }).eq('id', paymentId);
  }
}
