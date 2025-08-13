import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/student_provider.dart';
import '../../../core/providers/supabase_provider.dart';

class SessionFeedbackDialog extends ConsumerStatefulWidget {
  final String sessionId;

  const SessionFeedbackDialog({super.key, required this.sessionId});

  @override
  ConsumerState<SessionFeedbackDialog> createState() =>
      _SessionFeedbackDialogState();
}

class _SessionFeedbackDialogState extends ConsumerState<SessionFeedbackDialog> {
  double _rating = 5.0;
  String _feedback = '';
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Session Feedback'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('How would you rate this session?'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _rating.round().toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Icon(Icons.star, color: Colors.amber),
                ],
              ),
              Slider(
                value: _rating,
                min: 1.0,
                max: 5.0,
                divisions: 4,
                label: _rating.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Additional Comments',
                  hintText: 'Share your thoughts about the session...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide some feedback';
                  }
                  if (value.length < 10) {
                    return 'Please provide more detailed feedback';
                  }
                  return null;
                },
                onChanged: (value) {
                  _feedback = value;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting
              ? null
              : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isSubmitting = true;
                    });

                    final navigator = Navigator.of(context);
                    final messenger = ScaffoldMessenger.of(context);

                    try {
                      await ref
                          .read(
                            studentNotifierProvider(
                              ref
                                  .read(supabaseServiceProvider)
                                  .client
                                  .auth
                                  .currentUser!
                                  .id,
                            ).notifier,
                          )
                          .submitSessionFeedback(
                            widget.sessionId,
                            _rating,
                            _feedback,
                          );

                      navigator.pop();
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text('Feedback submitted successfully'),
                        ),
                      );
                    } catch (e) {
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } finally {
                      if (mounted) {
                        setState(() {
                          _isSubmitting = false;
                        });
                      }
                    }
                  }
                },
          child: _isSubmitting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                )
              : const Text('SUBMIT'),
        ),
      ],
    );
  }
}
