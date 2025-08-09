import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../widgets/student_scaffold.dart';
import '../providers/student_provider.dart';
import '../widgets/assignment_submission_form.dart';
import '../../../core/utils/download_helper.dart';

class AssignmentDetailScreen extends ConsumerWidget {
  final String assignmentId;

  const AssignmentDetailScreen({super.key, required this.assignmentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentAsync = ref.watch(assignmentProvider(assignmentId));

    return StudentScaffold(
      title: 'Assignment Details',
      currentIndex: 3,
      body: assignmentAsync.when(
        data: (assignment) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assignment['title'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Due: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(assignment['due_date']))}',
                          ),
                        ],
                      ),
                      if (assignment['submitted_at'] != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Submitted: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(assignment['submitted_at']))}',
                            ),
                          ],
                        ),
                      ],
                      if (assignment['score'] != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Score: ${((assignment['score'] as num) * 100).round()}%',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 16),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        assignment['description'] ?? 'No description provided',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (assignment['materials'] != null &&
                  (assignment['materials'] as List).isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assignment Materials',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (assignment['materials'] as List).length,
                          itemBuilder: (context, index) {
                            final material = assignment['materials'][index];
                            return ListTile(
                              leading: const Icon(Icons.attachment),
                              title: Text(material['name']),
                              trailing: IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: () {
                                  DownloadHelper.downloadFile(
                                    context: context,
                                    url: material['file_url'],
                                    fileName: material['name'],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assignment['submitted_at'] == null
                            ? 'Submit Assignment'
                            : 'Your Submission',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      if (assignment['submitted_at'] == null)
                        AssignmentSubmissionForm(assignmentId: assignmentId)
                      else if (assignment['feedback'] != null) ...[
                        Text(
                          'Feedback from Tutor:',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(assignment['feedback']),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
