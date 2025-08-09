import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';

class AssignmentSubmissionForm extends ConsumerStatefulWidget {
  final String assignmentId;

  const AssignmentSubmissionForm({super.key, required this.assignmentId});

  @override
  ConsumerState<AssignmentSubmissionForm> createState() =>
      _AssignmentSubmissionFormState();
}

class _AssignmentSubmissionFormState
    extends ConsumerState<AssignmentSubmissionForm> {
  final _formKey = GlobalKey<FormState>();
  String _comment = '';
  FilePickerResult? _selectedFile;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Submission Comment',
              hintText: 'Add any comments about your submission...',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please add a comment';
              }
              return null;
            },
            onChanged: (value) {
              _comment = value;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.attach_file),
            label: Text(
              _selectedFile != null
                  ? _selectedFile!.files.first.name
                  : 'Select File',
            ),
            onPressed: _pickFile,
          ),
          if (_selectedFile != null) ...[
            const SizedBox(height: 8),
            Text(
              'Size: ${(_selectedFile!.files.first.size / 1024 / 1024).toStringAsFixed(2)} MB',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitAssignment,
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : const Text('Submit Assignment'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _selectedFile = result;
      });
    }
  }

  Future<void> _submitAssignment() async {
    if (!_formKey.currentState!.validate() || _selectedFile == null) {
      if (_selectedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a file to submit')),
        );
      }
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final user = ref.read(supabaseServiceProvider).client.auth.currentUser!;
      await ref
          .read(studentNotifierProvider(user.id).notifier)
          .submitAssignment(
            widget.assignmentId,
            _comment,
            File(_selectedFile!.files.first.path!),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assignment submitted successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}
