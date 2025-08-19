import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pricing_plan.dart';
import '../services/pricing_service.dart';

final tutorPricingProvider = FutureProvider.family<PricingPlan?, String>((
  ref,
  tutorId,
) async {
  final service = ref.watch(pricingServiceProvider);
  return service.getTutorPricingPlan(tutorId);
});

final pricingControllerProvider =
    StateNotifierProvider.family<PricingController, AsyncValue<void>, String>(
      (ref, tutorId) => PricingController(ref, tutorId),
    );

class PricingController extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;
  final String _tutorId;

  PricingController(this._ref, this._tutorId)
    : super(const AsyncValue.data(null));

  Future<void> setPricingPlan({
    required double monthlyRate,
    String? description,
    List<String>? features,
  }) async {
    state = const AsyncValue.loading();
    try {
      final plan = PricingPlan(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        tutorId: _tutorId,
        monthlyRate: monthlyRate,
        description: description,
        features: features ?? [],
        createdAt: DateTime.now(),
      );

      await _ref.read(pricingServiceProvider).setPricingPlan(plan);
      _ref.invalidate(tutorPricingProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
