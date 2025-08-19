import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final String selectedSubject;
  final String selectedPriceRange;
  final String selectedRating;
  final bool isOnlineOnly;
  final Function(String, String, String, bool) onApplyFilters;

  const FilterBottomSheet({
    super.key,
    required this.selectedSubject,
    required this.selectedPriceRange,
    required this.selectedRating,
    required this.isOnlineOnly,
    required this.onApplyFilters,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String _selectedSubject;
  late String _selectedPriceRange;
  late String _selectedRating;
  late bool _isOnlineOnly;

  @override
  void initState() {
    super.initState();
    _selectedSubject = widget.selectedSubject;
    _selectedPriceRange = widget.selectedPriceRange;
    _selectedRating = widget.selectedRating;
    _isOnlineOnly = widget.isOnlineOnly;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),
          _buildHeader(),
          _buildSubjectFilter(),
          _buildPriceFilter(),
          _buildRatingFilter(),
          _buildOnlineFilter(),
          _buildActions(),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Text(
            'Filters',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          TextButton(onPressed: _resetFilters, child: const Text('Reset')),
        ],
      ),
    );
  }

  Widget _buildSubjectFilter() {
    final subjects = [
      'All',
      'Mathematics',
      'Physics',
      'Chemistry',
      'Biology',
      'English',
      'History',
      'Computer Science',
    ];

    return _buildFilterSection(
      'Subject',
      Icons.book,
      subjects,
      _selectedSubject,
      (value) => setState(() => _selectedSubject = value),
    );
  }

  Widget _buildPriceFilter() {
    final priceRanges = [
      'All',
      'Under \$20',
      '\$20 - \$40',
      '\$40 - \$60',
      '\$60+',
    ];

    return _buildFilterSection(
      'Price Range',
      Icons.attach_money,
      priceRanges,
      _selectedPriceRange,
      (value) => setState(() => _selectedPriceRange = value),
    );
  }

  Widget _buildRatingFilter() {
    final ratings = ['All', '4.0', '4.5', '4.8'];

    return _buildFilterSection(
      'Minimum Rating',
      Icons.star,
      ratings,
      _selectedRating,
      (value) => setState(() => _selectedRating = value),
    );
  }

  Widget _buildOnlineFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(Icons.wifi, color: Colors.green.shade600),
          const SizedBox(width: 16),
          const Text(
            'Online Only',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Switch(
            value: _isOnlineOnly,
            onChanged: (value) => setState(() => _isOnlineOnly = value),
            activeThumbColor: Colors.green.shade600,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    IconData icon,
    List<String> options,
    String selectedValue,
    Function(String) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue.shade600),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final isSelected = option == selectedValue;
              return GestureDetector(
                onTap: () => onChanged(option),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue.shade600
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.blue.shade600
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Cancel'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _selectedSubject = 'All';
      _selectedPriceRange = 'All';
      _selectedRating = 'All';
      _isOnlineOnly = false;
    });
  }

  void _applyFilters() {
    widget.onApplyFilters(
      _selectedSubject,
      _selectedPriceRange,
      _selectedRating,
      _isOnlineOnly,
    );
  }
}
