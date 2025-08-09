import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/search_service.dart';
import 'widgets/search_filter_dialog.dart';
import 'widgets/tutor_card.dart';
import 'widgets/session_card.dart';
import 'widgets/assignment_card.dart';

enum SearchCategory { tutors, sessions, assignments }

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  SearchCategory _currentCategory = SearchCategory.tutors;
  Map<String, dynamic> _filters = {};
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _performSearch();
  }

  Future<void> _performSearch() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final searchService = ref.read(searchServiceProvider);
      List<Map<String, dynamic>> results = [];

      switch (_currentCategory) {
        case SearchCategory.tutors:
          results = await searchService.searchTutors(
            query: _searchController.text,
            subjects: _filters['subjects'] as List<String>?,
            availability: _filters['availability'] as String?,
            minRating: _filters['minRating'] as double?,
            sortBy: _filters['sortBy'] as String?,
          );
          break;

        case SearchCategory.sessions:
          results = await searchService.searchSessions(
            tutorName: _searchController.text,
            subject: _filters['subject'] as String?,
            startDate: _filters['startDate'] as DateTime?,
            endDate: _filters['endDate'] as DateTime?,
            status: _filters['status'] as String?,
          );
          break;

        case SearchCategory.assignments:
          results = await searchService.searchAssignments(
            query: _searchController.text,
            subject: _filters['subject'] as String?,
            status: _filters['status'] as String?,
            dueAfter: _filters['dueAfter'] as DateTime?,
            dueBefore: _filters['dueBefore'] as DateTime?,
          );
          break;
      }

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Search failed: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search ${_currentCategory.name}...',
              onChanged: (_) => _performSearch(),
              trailing: [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () async {
                    final newFilters = await showDialog<Map<String, dynamic>>(
                      context: context,
                      builder: (context) => SearchFilterDialog(
                        category: _currentCategory,
                        currentFilters: _filters,
                      ),
                    );
                    if (newFilters != null) {
                      setState(() {
                        _filters = newFilters;
                      });
                      _performSearch();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: SearchCategory.values.map((category) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChoiceChip(
                    label: Text(category.name),
                    selected: _currentCategory == category,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _currentCategory = category;
                          _filters = {};
                        });
                        _performSearch();
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty
                ? const Center(child: Text('No results found'))
                : ListView.builder(
                    itemCount: _searchResults.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final result = _searchResults[index];
                      switch (_currentCategory) {
                        case SearchCategory.tutors:
                          return TutorCard(tutor: result);
                        case SearchCategory.sessions:
                          return SessionCard(session: result);
                        case SearchCategory.assignments:
                          return AssignmentCard(assignment: result);
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
