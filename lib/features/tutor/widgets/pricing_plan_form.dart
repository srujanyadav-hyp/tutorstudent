import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pricing_provider.dart';
import '../../../core/utils/snackbar_utils.dart';

class PricingPlanForm extends ConsumerStatefulWidget {
  final String tutorId;

  const PricingPlanForm({super.key, required this.tutorId});

  @override
  ConsumerState<PricingPlanForm> createState() => _PricingPlanFormState();
}

class _PricingPlanFormState extends ConsumerState<PricingPlanForm> {
  final _formKey = GlobalKey<FormState>();
  final _monthlyRateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> _features = [];
  final _featureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadExistingPlan();
  }

  Future<void> _loadExistingPlan() async {
    final plan = await ref.read(tutorPricingProvider(widget.tutorId).future);
    if (plan != null) {
      setState(() {
        _monthlyRateController.text = plan.monthlyRate.toString();
        _descriptionController.text = plan.description ?? '';
        _features.addAll(plan.features);
      });
    }
  }

  @override
  void dispose() {
    _monthlyRateController.dispose();
    _descriptionController.dispose();
    _featureController.dispose();
    super.dispose();
  }

  void _addFeature() {
    if (_featureController.text.isNotEmpty) {
      setState(() {
        _features.add(_featureController.text);
        _featureController.clear();
      });
    }
  }

  void _removeFeature(int index) {
    setState(() {
      _features.removeAt(index);
    });
  }

  Future<void> _savePlan() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await ref
          .read(pricingControllerProvider(widget.tutorId).notifier)
          .setPricingPlan(
            monthlyRate: double.parse(_monthlyRateController.text),
            description: _descriptionController.text.isEmpty
                ? null
                : _descriptionController.text,
            features: _features,
          );

      if (mounted) {
        showSuccessSnackBar(context, 'Pricing plan updated successfully');
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, 'Failed to update pricing plan');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(pricingControllerProvider(widget.tutorId));

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _monthlyRateController,
            decoration: const InputDecoration(
              labelText: 'Monthly Rate',
              prefixText: '\$',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a monthly rate';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description (optional)',
              hintText: 'Describe what\'s included in the monthly plan',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _featureController,
                  decoration: const InputDecoration(
                    labelText: 'Add Feature',
                    hintText: 'e.g., Weekly progress reports',
                  ),
                ),
              ),
              IconButton(onPressed: _addFeature, icon: const Icon(Icons.add)),
            ],
          ),
          const SizedBox(height: 8),
          if (_features.isNotEmpty) ...[
            const Text(
              'Features:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _features.length,
              itemBuilder: (context, index) => ListTile(
                dense: true,
                leading: const Icon(Icons.check, size: 20),
                title: Text(_features[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline, size: 20),
                  onPressed: () => _removeFeature(index),
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: status.isLoading ? null : _savePlan,
              child: status.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Save Pricing Plan'),
            ),
          ),
        ],
      ),
    );
  }
}
