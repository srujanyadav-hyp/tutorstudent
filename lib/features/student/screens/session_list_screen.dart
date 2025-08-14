import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';
import '../widgets/session_card.dart';
import '../widgets/student_scaffold.dart';

class SessionListScreen extends ConsumerStatefulWidget {
  const SessionListScreen({super.key});

  @override
  ConsumerState<SessionListScreen> createState() => _SessionListScreenState();
}

class _SessionListScreenState extends ConsumerState<SessionListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showCalendarView = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final sessionsAsync = ref.watch(upcomingSessionsFilteredProvider(user.id));

    return StudentScaffold(
      title: 'My Sessions',
      currentIndex: 2,
      actions: [
        IconButton(
          icon: Icon(_showCalendarView ? Icons.list : Icons.calendar_month),
          onPressed: () {
            setState(() {
              _showCalendarView = !_showCalendarView;
            });
          },
          tooltip: _showCalendarView ? 'List View' : 'Calendar View',
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearchDialog(context),
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.filter_list),
          onSelected: (value) {
            switch (value) {
              case 'all':
                ref.read(sessionFilterProvider.notifier).state =
                    SessionFilter.all;
                break;
              case 'upcoming':
                ref.read(sessionFilterProvider.notifier).state =
                    SessionFilter.upcoming;
                break;
              case 'live':
                ref.read(sessionFilterProvider.notifier).state =
                    SessionFilter.live;
                break;
              case 'completed':
                ref.read(sessionFilterProvider.notifier).state =
                    SessionFilter.completed;
                break;
              case 'cancelled':
                ref.read(sessionFilterProvider.notifier).state =
                    SessionFilter.cancelled;
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'all', child: Text('All')),
            PopupMenuItem(value: 'upcoming', child: Text('Upcoming')),
            PopupMenuItem(value: 'live', child: Text('Live')),
            PopupMenuItem(value: 'completed', child: Text('Completed')),
            PopupMenuItem(value: 'cancelled', child: Text('Cancelled')),
          ],
        ),
      ],
      body: Column(
        children: [
          _buildFilterChips(),
          if (_showCalendarView) _buildCalendarView(),
          Expanded(
            child: sessionsAsync.when(
              data: (sessions) {
                if (sessions.isEmpty) {
                  return _buildEmptyState();
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(upcomingSessionsProvider(user.id).future),
                  child: _showCalendarView
                      ? _buildCalendarSessions(sessions)
                      : _buildSessionsList(sessions),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => _buildErrorState(error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('All', SessionFilter.all),
            const SizedBox(width: 8),
            _buildFilterChip('Upcoming', SessionFilter.upcoming),
            const SizedBox(width: 8),
            _buildFilterChip('Live', SessionFilter.live),
            const SizedBox(width: 8),
            _buildFilterChip('Completed', SessionFilter.completed),
            const SizedBox(width: 8),
            _buildFilterChip('Cancelled', SessionFilter.cancelled),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, SessionFilter filter) {
    final currentFilter = ref.watch(sessionFilterProvider);
    final isSelected = currentFilter == filter;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        ref.read(sessionFilterProvider.notifier).state = filter;
      },
      selectedColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.2),
      checkmarkColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildCalendarView() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Calendar',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      setState(() {
                        _selectedDate = DateTime(
                          _selectedDate.year,
                          _selectedDate.month - 1,
                        );
                      });
                    },
                  ),
                  Text(
                    '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      setState(() {
                        _selectedDate = DateTime(
                          _selectedDate.year,
                          _selectedDate.month + 1,
                        );
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _selectedDate.year,
      _selectedDate.month + 1,
      0,
    );
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    return Column(
      children: [
        Row(
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map(
                (day) => Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        ...List.generate(
          ((firstWeekday - 1 + daysInMonth) / 7).ceil(),
          (weekIndex) => Row(
            children: List.generate(7, (dayIndex) {
              final dayNumber =
                  weekIndex * 7 + dayIndex - (firstWeekday - 1) + 1;
              final isValidDay = dayNumber > 0 && dayNumber <= daysInMonth;
              final isToday =
                  dayNumber == DateTime.now().day &&
                  _selectedDate.month == DateTime.now().month &&
                  _selectedDate.year == DateTime.now().year;

              return Expanded(
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: isToday
                        ? Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: isToday
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          )
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      isValidDay ? dayNumber.toString() : '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: isToday
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isToday
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarSessions(List<Map<String, dynamic>> sessions) {
    // Group sessions by date
    final sessionsByDate = <String, List<Map<String, dynamic>>>{};
    for (final session in sessions) {
      final date = DateTime.parse(session['start_time']).toLocal();
      final dateKey =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      sessionsByDate.putIfAbsent(dateKey, () => []).add(session);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sessionsByDate.length,
      itemBuilder: (context, index) {
        final dateKey = sessionsByDate.keys.elementAt(index);
        final dateSessions = sessionsByDate[dateKey]!;
        final date = DateTime.parse('$dateKey 00:00:00');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                _formatDate(date),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            ...dateSessions.map((session) => SessionCard(session: session)),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildSessionsList(List<Map<String, dynamic>> sessions) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sessions.length,
      itemBuilder: (context, index) => SessionCard(session: sessions[index]),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.calendar_today_outlined,
              size: 64,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No sessions scheduled',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Book a session with a tutor to get started',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to book session
            },
            icon: const Icon(Icons.add),
            label: const Text('Book Session'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red.shade400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.red.shade700),
          ),
          const SizedBox(height: 8),
          Text(
            'Error: $error',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => ref.refresh(
              upcomingSessionsProvider(
                ref.read(supabaseServiceProvider).client.auth.currentUser!.id,
              ).future,
            ),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Sessions'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search by tutor name, subject, or notes...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement search functionality
              Navigator.pop(context);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == tomorrow) {
      return 'Tomorrow';
    } else {
      return '${_getMonthName(date.month)} ${date.day}';
    }
  }
}
