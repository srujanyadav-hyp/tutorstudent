import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/search_provider.dart';
import '../widgets/tutor_card.dart';
import '../widgets/filter_bottom_sheet.dart';

class TutorSearchScreen extends ConsumerStatefulWidget {
  const TutorSearchScreen({super.key});

  @override
  ConsumerState<TutorSearchScreen> createState() => _TutorSearchScreenState();
}

class _TutorSearchScreenState extends ConsumerState<TutorSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSubject = 'All';
  String _selectedPriceRange = 'All';
  String _selectedRating = 'All';
  bool _isOnlineOnly = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    ref.read(searchQueryProvider.notifier).state = _searchController.text;
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        selectedSubject: _selectedSubject,
        selectedPriceRange: _selectedPriceRange,
        selectedRating: _selectedRating,
        isOnlineOnly: _isOnlineOnly,
        onApplyFilters: (subject, priceRange, rating, onlineOnly) {
          setState(() {
            _selectedSubject = subject;
            _selectedPriceRange = priceRange;
            _selectedRating = rating;
            _isOnlineOnly = onlineOnly;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final tutorsAsync = ref.watch(
      filteredTutorsProvider({
        'query': searchQuery,
        'subject': _selectedSubject,
        'priceRange': _selectedPriceRange,
        'rating': _selectedRating,
        'onlineOnly': _isOnlineOnly,
      }),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Tutors',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade800,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildActiveFilters(),
          Expanded(
            child: tutorsAsync.when(
              data: (tutors) {
                if (tutors.isEmpty) {
                  return _buildEmptyState();
                }
                return _buildTutorsList(tutors);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search tutors by name, subject, or expertise...',
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey.shade600),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFilters() {
    final hasActiveFilters =
        _selectedSubject != 'All' ||
        _selectedPriceRange != 'All' ||
        _selectedRating != 'All' ||
        _isOnlineOnly;

    if (!hasActiveFilters) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (_selectedSubject != 'All')
              _buildFilterChip(
                'Subject: $_selectedSubject',
                Icons.book,
                Colors.blue,
                () => setState(() => _selectedSubject = 'All'),
              ),
            if (_selectedPriceRange != 'All')
              _buildFilterChip(
                'Price: $_selectedPriceRange',
                Icons.attach_money,
                Colors.green,
                () => setState(() => _selectedPriceRange = 'All'),
              ),
            if (_selectedRating != 'All')
              _buildFilterChip(
                'Rating: $_selectedRating+',
                Icons.star,
                Colors.orange,
                () => setState(() => _selectedRating = 'All'),
              ),
            if (_isOnlineOnly)
              _buildFilterChip(
                'Online Only',
                Icons.wifi,
                Colors.purple,
                () => setState(() => _isOnlineOnly = false),
              ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedSubject = 'All';
                  _selectedPriceRange = 'All';
                  _selectedRating = 'All';
                  _isOnlineOnly = false;
                });
              },
              child: const Text('Clear All'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    IconData icon,
    Color color,
    VoidCallback onRemove,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        deleteIcon: Icon(Icons.close, size: 16),
        onDeleted: onRemove,
        backgroundColor: color.withValues(alpha: 0.1),
        side: BorderSide(color: color.withValues(alpha: 0.3)),
      ),
    );
  }

  Widget _buildTutorsList(List<Map<String, dynamic>> tutors) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tutors.length,
      itemBuilder: (context, index) {
        final tutor = tutors[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TutorCard(
            tutor: tutor,
            onTap: () => _navigateToTutorProfile(tutor),
            onBookSession: () => _bookSession(tutor),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No tutors found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search criteria or filters',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _selectedSubject = 'All';
                _selectedPriceRange = 'All';
                _selectedRating = 'All';
                _isOnlineOnly = false;
                _searchController.clear();
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Clear Filters'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToTutorProfile(Map<String, dynamic> tutor) {
    GoRouter.of(context).go('/tutor/${tutor['id']}');
  }

  void _bookSession(Map<String, dynamic> tutor) {
    GoRouter.of(context).go('/book-session/${tutor['id']}');
  }
}
