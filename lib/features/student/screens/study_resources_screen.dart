import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../widgets/student_scaffold.dart';

class StudyResourcesScreen extends ConsumerStatefulWidget {
  const StudyResourcesScreen({super.key});

  @override
  ConsumerState<StudyResourcesScreen> createState() =>
      _StudyResourcesScreenState();
}

class _StudyResourcesScreenState extends ConsumerState<StudyResourcesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSubject = 'All';

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

    return StudentScaffold(
      title: 'Study Resources',
      currentIndex: 5, // Assuming this is a new tab
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearchDialog(context),
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.filter_list),
          onSelected: (value) {
            setState(() {
              // _selectedResourceType = value; // This line is removed
            });
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'All', child: Text('All Resources')),
            PopupMenuItem(value: 'Videos', child: Text('Videos')),
            PopupMenuItem(value: 'Documents', child: Text('Documents')),
            PopupMenuItem(
              value: 'Practice Tests',
              child: Text('Practice Tests'),
            ),
            PopupMenuItem(value: 'Interactive', child: Text('Interactive')),
          ],
        ),
      ],
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // TODO: Refresh resources
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildQuickAccessSection(),
                  const SizedBox(height: 24),
                  _buildSubjectResources(),
                  const SizedBox(height: 24),
                  _buildRecentResources(),
                  const SizedBox(height: 24),
                  _buildPracticeTests(),
                ],
              ),
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
            _buildFilterChip('All', 'All'),
            const SizedBox(width: 8),
            _buildFilterChip('Math', 'Math'),
            const SizedBox(width: 8),
            _buildFilterChip('Science', 'Science'),
            const SizedBox(width: 8),
            _buildFilterChip('English', 'English'),
            const SizedBox(width: 8),
            _buildFilterChip('History', 'History'),
            const SizedBox(width: 8),
            _buildFilterChip('Programming', 'Programming'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String subject) {
    final isSelected = _selectedSubject == subject;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedSubject = subject;
        });
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

  Widget _buildQuickAccessSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Access',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildQuickAccessCard(
              'Practice Tests',
              Icons.quiz,
              Colors.blue,
              () => _navigateToPracticeTests(),
            ),
            _buildQuickAccessCard(
              'Video Lessons',
              Icons.video_library,
              Colors.green,
              () => _navigateToVideoLessons(),
            ),
            _buildQuickAccessCard(
              'Study Guides',
              Icons.book,
              Colors.orange,
              () => _navigateToStudyGuides(),
            ),
            _buildQuickAccessCard(
              'Flashcards',
              Icons.style,
              Colors.purple,
              () => _navigateToFlashcards(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32, color: color),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectResources() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subject Resources',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildSubjectCard(
          'Mathematics',
          'Algebra, Calculus, Geometry',
          Icons.functions,
          Colors.blue,
          ['Videos', 'Practice Problems', 'Formulas'],
        ),
        const SizedBox(height: 16),
        _buildSubjectCard(
          'Science',
          'Physics, Chemistry, Biology',
          Icons.science,
          Colors.green,
          ['Experiments', 'Diagrams', 'Explanations'],
        ),
        const SizedBox(height: 16),
        _buildSubjectCard(
          'English',
          'Literature, Grammar, Writing',
          Icons.language,
          Colors.orange,
          ['Essays', 'Grammar Rules', 'Reading Lists'],
        ),
      ],
    );
  }

  Widget _buildSubjectCard(
    String subject,
    String description,
    IconData icon,
    Color color,
    List<String> resources,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () => _navigateToSubject(subject),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: resources
                  .map(
                    (resource) => Chip(
                      label: Text(resource),
                      backgroundColor: color.withValues(alpha: 0.1),
                      labelStyle: TextStyle(color: color, fontSize: 12),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentResources() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recently Viewed',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildResourceItem(
          'Introduction to Calculus',
          'Mathematics',
          '2 hours ago',
          Icons.functions,
          Colors.blue,
        ),
        const SizedBox(height: 8),
        _buildResourceItem(
          'Chemical Bonding Explained',
          'Chemistry',
          '1 day ago',
          Icons.science,
          Colors.green,
        ),
        const SizedBox(height: 8),
        _buildResourceItem(
          'Essay Writing Tips',
          'English',
          '3 days ago',
          Icons.edit,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildResourceItem(
    String title,
    String subject,
    String timeAgo,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          '$subject • $timeAgo',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.play_circle_outline),
          onPressed: () => _openResource(title),
        ),
      ),
    );
  }

  Widget _buildPracticeTests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Practice Tests',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildTestCard(
          'Algebra Fundamentals',
          'Mathematics',
          '20 questions',
          '30 min',
          '85%',
          Colors.blue,
        ),
        const SizedBox(height: 16),
        _buildTestCard(
          'Chemistry Basics',
          'Science',
          '25 questions',
          '45 min',
          '92%',
          Colors.green,
        ),
        const SizedBox(height: 16),
        _buildTestCard(
          'Grammar Review',
          'English',
          '15 questions',
          '20 min',
          '78%',
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildTestCard(
    String title,
    String subject,
    String questions,
    String duration,
    String score,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subject,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    score,
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.quiz, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 6),
                Text(
                  questions,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 6),
                Text(
                  duration,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Test'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => _startPracticeTest(title),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Resources'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search for study materials...',
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

  void _navigateToPracticeTests() {
    // TODO: Navigate to practice tests
  }

  void _navigateToVideoLessons() {
    // TODO: Navigate to video lessons
  }

  void _navigateToStudyGuides() {
    // TODO: Navigate to study guides
  }

  void _navigateToFlashcards() {
    // TODO: Navigate to flashcards
  }

  void _navigateToSubject(String subject) {
    // TODO: Navigate to subject resources
  }

  void _openResource(String title) {
    // TODO: Open resource
  }

  void _startPracticeTest(String title) {
    // TODO: Start practice test
  }
}
