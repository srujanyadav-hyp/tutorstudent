import 'package:flutter/material.dart';
import '../models/tutor_session.dart';
import '../../../features/auth/widgets/custom_text_form_field.dart';

class SessionForm extends StatefulWidget {
  final TutorSession? session;
  final Function(String title, String? description, DateTime scheduledAt,
      String? videoLink) onSubmit;

  const SessionForm({
    super.key,
    this.session,
    required this.onSubmit,
  });

  @override
  State<SessionForm> createState() => _SessionFormState();
}

class _SessionFormState extends State<SessionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _videoLinkController = TextEditingController();
  DateTime _scheduledAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.session != null) {
      _titleController.text = widget.session!.title;
      _descriptionController.text = widget.session?.description ?? '';
      _videoLinkController.text = widget.session?.videoLink ?? '';
      _scheduledAt = widget.session!.scheduledAt;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _videoLinkController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      if (!mounted) return;

      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_scheduledAt),
      );

      if (time != null) {
        setState(() {
          _scheduledAt = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        _titleController.text,
        _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        _scheduledAt,
        _videoLinkController.text.isEmpty ? null : _videoLinkController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: _titleController,
            label: 'Session Title',
            hint: 'Enter the session title',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: _descriptionController,
            label: 'Description',
            hint: 'Enter session description',
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Scheduled Date & Time'),
            subtitle: Text(
              '${_scheduledAt.toLocal()}'.split('.')[0],
              style: const TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: _selectDateTime,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: _videoLinkController,
            label: 'Video Link',
            hint: 'Enter video conference link (optional)',
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: Text(
                widget.session == null ? 'Create Session' : 'Update Session'),
          ),
        ],
      ),
    );
  }
}
