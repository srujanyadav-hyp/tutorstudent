import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../widgets/student_scaffold.dart';
import '../providers/student_provider.dart';
import '../widgets/session_feedback_dialog.dart';
import '../../../core/utils/download_helper.dart';

class SessionDetailScreen extends ConsumerWidget {
  final String sessionId;

  const SessionDetailScreen({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionProvider(sessionId));

    return StudentScaffold(
      title: 'Session Details',
      currentIndex: 2,
      body: sessionAsync.when(
        data: (session) => SingleChildScrollView(
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
                        session['title'] ?? 'Tutoring Session',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat(
                              'MMM dd, yyyy - hh:mm a',
                            ).format(DateTime.parse(session['scheduled_at'])),
                          ),
                        ],
                      ),
                      if (session['description'] != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(session['description']),
                      ],
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
                        'Tutor',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              session['tutor_profile_image'] != null
                              ? NetworkImage(session['tutor_profile_image'])
                              : null,
                          child: session['tutor_profile_image'] == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        title: Text(session['tutor_name'] ?? 'Unknown'),
                        subtitle: Text(session['tutor_email'] ?? ''),
                        trailing: IconButton(
                          icon: const Icon(Icons.message),
                          onPressed: () {
                            // TODO: Navigate to chat with tutor
                          },
                        ),
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
                        'Session Materials',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      if (session['materials'] != null &&
                          (session['materials'] as List).isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (session['materials'] as List).length,
                          itemBuilder: (context, index) {
                            final material = session['materials'][index];
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
                        )
                      else
                        const Center(child: Text('No materials available')),
                    ],
                  ),
                ),
              ),
              if (session['feedback_enabled'] == true) ...[
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Session Feedback',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        if (session['session_feedback'] == null)
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    SessionFeedbackDialog(sessionId: sessionId),
                              );
                            },
                            child: const Text('Provide Feedback'),
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Your Rating: ${session['session_feedback']['rating']}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                  const Icon(Icons.star, color: Colors.amber),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Your Feedback:',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 4),
                              Text(session['session_feedback']['feedback']),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
