import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../models/student_management.dart';
import '../providers/student_management_provider.dart';

class EditStudentDialog extends ConsumerStatefulWidget {
  final ManagedStudent? student;

  const EditStudentDialog({super.key, this.student});

  @override
  ConsumerState<EditStudentDialog> createState() => _EditStudentDialogState();
}

class _EditStudentDialogState extends ConsumerState<EditStudentDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _gradeController;
  late final TextEditingController _subjectsController;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _gradeController = TextEditingController(text: widget.student?.grade);
    _subjectsController = TextEditingController(text: widget.student?.subjects);
    _isActive = widget.student?.isActive ?? true;
  }

  @override
  void dispose() {
    _gradeController.dispose();
    _subjectsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.student != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Student' : 'Add Student'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isEditing)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Student Email',
                  hintText: 'Enter student email to connect with',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a student email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            if (isEditing) ...[
              TextFormField(
                controller: _gradeController,
                decoration: const InputDecoration(
                  labelText: 'Grade',
                  hintText: 'Enter student grade',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectsController,
                decoration: const InputDecoration(
                  labelText: 'Subjects',
                  hintText: 'Enter subjects (comma separated)',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Switch(
                    value: _isActive,
                    onChanged: (value) {
                      setState(() {
                        _isActive = value;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text('Active Student'),
                ],
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (isEditing) {
                await ref
                    .read(
                      studentManagementProvider(widget.student!.id).notifier,
                    )
                    .updateStudentDetails(
                      widget.student!.id,
                      grade: _gradeController.text.isEmpty
                          ? null
                          : _gradeController.text,
                      subjects: _subjectsController.text.isEmpty
                          ? null
                          : _subjectsController.text,
                    );
              } else {
                final authState = ref.read(authStateProvider);
                if (authState.value != null) {
                  await ref
                      .read(
                        studentManagementProvider(authState.value!.id).notifier,
                      )
                      .addStudent(_subjectsController.text);
                }
              }

              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          child: Text(isEditing ? 'SAVE' : 'ADD'),
        ),
      ],
    );
  }
}
