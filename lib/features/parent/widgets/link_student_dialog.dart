import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/parent_dashboard_provider.dart';

class LinkStudentDialog extends ConsumerStatefulWidget {
  final String parentId;

  const LinkStudentDialog({super.key, required this.parentId});

  @override
  ConsumerState<LinkStudentDialog> createState() => _LinkStudentDialogState();
}

class _LinkStudentDialogState extends ConsumerState<LinkStudentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _studentEmailController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _studentEmailController.dispose();
    super.dispose();
  }

  Future<void> _linkStudent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await ref
          .read(parentDashboardServiceProvider)
          .linkStudent(widget.parentId, _studentEmailController.text.trim());

      if (!mounted) return;

      // Close the dialog after successful linking
      Navigator.of(context).pop(true);
    } catch (e) {
      setState(() {
        _error = 'Student not found with this email';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Link a Student'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _studentEmailController,
              decoration: const InputDecoration(
                labelText: 'Student Email',
                hintText: 'Enter student\'s email address',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter student\'s email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _linkStudent,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Link Student'),
        ),
      ],
    );
  }
}
