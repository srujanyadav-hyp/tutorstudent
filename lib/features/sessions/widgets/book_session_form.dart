import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../providers/session_booking_provider.dart';

class BookSessionForm extends ConsumerStatefulWidget {
  final String tutorId;
  final String tutorName;
  final double? monthlyRate;

  const BookSessionForm({
    super.key,
    required this.tutorId,
    required this.tutorName,
    this.monthlyRate,
  });

  @override
  ConsumerState<BookSessionForm> createState() => _BookSessionFormState();
}

class _BookSessionFormState extends ConsumerState<BookSessionForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now().replacing(
    hour: TimeOfDay.now().hour + 1,
  );
  final _topicController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _topicController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null) {
      setState(() {
        _startTime = picked;
        // Automatically set end time 1 hour after start time
        _endTime = TimeOfDay(hour: picked.hour + 1, minute: picked.minute);
      });
    }
  }

  Future<void> _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final startDateTime = _combineDateAndTime(_selectedDate, _startTime);
    final endDateTime = _combineDateAndTime(_selectedDate, _endTime);

    if (endDateTime.isBefore(startDateTime)) {
      showErrorSnackBar(context, 'End time must be after start time');
      return;
    }

    try {
      await ref
          .read(sessionBookingControllerProvider(widget.tutorId).notifier)
          .bookSession(
            startTime: startDateTime,
            endTime: endDateTime,
            topic: _topicController.text,
            notes: _notesController.text.isEmpty ? null : _notesController.text,
          );

      if (mounted) {
        showSuccessSnackBar(context, 'Session booked successfully');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, 'Failed to book session: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(sessionBookingControllerProvider(widget.tutorId));

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.monthlyRate != null) ...[
            Text(
              'Monthly Rate: \$${widget.monthlyRate!.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
          ],
          ListTile(
            title: Text(
              'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: _selectDate,
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text('Start: ${_startTime.format(context)}'),
                  trailing: const Icon(Icons.access_time),
                  onTap: _selectStartTime,
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('End: ${_endTime.format(context)}'),
                  trailing: const Icon(Icons.access_time),
                  onTap: _selectEndTime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _topicController,
            decoration: const InputDecoration(
              labelText: 'Topic',
              hintText: 'What would you like to learn?',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a topic';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Additional Notes (Optional)',
              hintText: 'Any specific requirements or questions?',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: status.isLoading ? null : _submitForm,
            child: status.isLoading
                ? const CircularProgressIndicator()
                : const Text('Book Session'),
          ),
        ],
      ),
    );
  }
}
