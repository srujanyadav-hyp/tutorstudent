import 'package:freezed_annotation/freezed_annotation.dart';

part 'pricing_plan.freezed.dart';
part 'pricing_plan.g.dart';

@freezed
class PricingPlan with _$PricingPlan {
  const factory PricingPlan({
    required String id,
    required String tutorId,
    required double monthlyRate,
    String? description,
    @Default([]) List<String> features,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PricingPlan;

  factory PricingPlan.fromJson(Map<String, dynamic> json) =>
      _$PricingPlanFromJson(json);
}
