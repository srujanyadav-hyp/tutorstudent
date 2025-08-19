import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/pricing_plan.dart';

final pricingServiceProvider = Provider((ref) => PricingService());

class PricingService {
  final _supabase = Supabase.instance.client;

  Future<void> setPricingPlan(PricingPlan plan) async {
    try {
      await _supabase.from('pricing_plans').upsert({
        'id': plan.id,
        'tutor_id': plan.tutorId,
        'monthly_rate': plan.monthlyRate,
        'description': plan.description,
        'features': plan.features,
        'created_at': plan.createdAt?.toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw 'Failed to set pricing plan: ${e.toString()}';
    }
  }

  Future<PricingPlan?> getTutorPricingPlan(String tutorId) async {
    try {
      final data = await _supabase
          .from('pricing_plans')
          .select()
          .eq('tutor_id', tutorId)
          .single();
      return data == null ? null : PricingPlan.fromJson(data);
    } catch (e) {
      throw 'Failed to get pricing plan: ${e.toString()}';
    }
  }
}
