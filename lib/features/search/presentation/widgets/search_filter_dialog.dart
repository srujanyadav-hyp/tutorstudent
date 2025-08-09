import 'package:flutter/material.dart';
import '../search_screen.dart';

class SearchFilterDialog extends StatefulWidget {
  final SearchCategory category;
  final Map<String, dynamic> currentFilters;

  const SearchFilterDialog({
    Key? key,
    required this.category,
    required this.currentFilters,
  }) : super(key: key);

  @override
  State<SearchFilterDialog> createState() => _SearchFilterDialogState();
}

class _SearchFilterDialogState extends State<SearchFilterDialog> {
  late Map<String, dynamic> _filters;

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter ${widget.category.name}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildFiltersForCategory(widget.category)],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _filters);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }

  Widget _buildFiltersForCategory(SearchCategory category) {
    switch (category) {
      case SearchCategory.tutors:
        return _buildTutorFilters();
      case SearchCategory.sessions:
        return _buildSessionFilters();
      case SearchCategory.assignments:
        return _buildAssignmentFilters();
    }
  }

  Widget _buildTutorFilters() {
    return Column(
      children: [
        // Subjects multiselect
        DropdownButtonFormField<String>(
          value: _filters['subject'] as String?,
          decoration: const InputDecoration(labelText: 'Subject'),
          items: const [
            DropdownMenuItem(value: 'math', child: Text('Mathematics')),
            DropdownMenuItem(value: 'science', child: Text('Science')),
            DropdownMenuItem(value: 'english', child: Text('English')),
          ],
          onChanged: (value) {
            setState(() {
              _filters['subject'] = value;
            });
          },
        ),
        // Availability
        DropdownButtonFormField<String>(
          value: _filters['availability'] as String?,
          decoration: const InputDecoration(labelText: 'Availability'),
          items: const [
            DropdownMenuItem(value: 'morning', child: Text('Morning')),
            DropdownMenuItem(value: 'afternoon', child: Text('Afternoon')),
            DropdownMenuItem(value: 'evening', child: Text('Evening')),
          ],
          onChanged: (value) {
            setState(() {
              _filters['availability'] = value;
            });
          },
        ),
        // Rating slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Minimum Rating'),
            Slider(
              value: (_filters['minRating'] as double?) ?? 0.0,
              min: 0.0,
              max: 5.0,
              divisions: 10,
              label: '${(_filters['minRating'] ?? 0.0).toStringAsFixed(1)}',
              onChanged: (value) {
                setState(() {
                  _filters['minRating'] = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSessionFilters() {
    return Column(
      children: [
        // Date range
        ListTile(
          title: const Text('Start Date'),
          subtitle: Text(_filters['startDate']?.toString() ?? 'Not set'),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              setState(() {
                _filters['startDate'] = date;
              });
            }
          },
        ),
        ListTile(
          title: const Text('End Date'),
          subtitle: Text(_filters['endDate']?.toString() ?? 'Not set'),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              setState(() {
                _filters['endDate'] = date;
              });
            }
          },
        ),
        // Status
        DropdownButtonFormField<String>(
          value: _filters['status'] as String?,
          decoration: const InputDecoration(labelText: 'Status'),
          items: const [
            DropdownMenuItem(value: 'upcoming', child: Text('Upcoming')),
            DropdownMenuItem(value: 'completed', child: Text('Completed')),
            DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
          ],
          onChanged: (value) {
            setState(() {
              _filters['status'] = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAssignmentFilters() {
    return Column(
      children: [
        // Due date range
        ListTile(
          title: const Text('Due After'),
          subtitle: Text(_filters['dueAfter']?.toString() ?? 'Not set'),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              setState(() {
                _filters['dueAfter'] = date;
              });
            }
          },
        ),
        ListTile(
          title: const Text('Due Before'),
          subtitle: Text(_filters['dueBefore']?.toString() ?? 'Not set'),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              setState(() {
                _filters['dueBefore'] = date;
              });
            }
          },
        ),
        // Status
        DropdownButtonFormField<String>(
          value: _filters['status'] as String?,
          decoration: const InputDecoration(labelText: 'Status'),
          items: const [
            DropdownMenuItem(value: 'pending', child: Text('Pending')),
            DropdownMenuItem(value: 'submitted', child: Text('Submitted')),
            DropdownMenuItem(value: 'graded', child: Text('Graded')),
            DropdownMenuItem(value: 'overdue', child: Text('Overdue')),
          ],
          onChanged: (value) {
            setState(() {
              _filters['status'] = value;
            });
          },
        ),
      ],
    );
  }
}
