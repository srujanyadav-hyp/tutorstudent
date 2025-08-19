import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/download_helper.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_provider.dart';
import '../widgets/student_scaffold.dart';
import '../widgets/error_view.dart';

class StudentResourcesScreen extends ConsumerWidget {
  const StudentResourcesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return Scaffold(
        body: ErrorView(
          message: 'You need to be signed in to access resources.',
          onRetry: () => ref.refresh(supabaseServiceProvider),
        ),
      );
    }

    final resourcesAsync = ref.watch(studentResourcesProvider(user.id));

    return StudentScaffold(
      title: 'Resources',
      currentIndex: 4,
      body: resourcesAsync.when(
        data: (resources) {
          if (resources.isEmpty) {
            return _buildEmptyState(context);
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final resource = resources[index];
              return _buildResourceCard(context, resource);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorView(
          message: 'Failed to load resources: $error',
          onRetry: () => ref.refresh(studentResourcesProvider(user.id)),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No resources available',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Your tutors will share study materials here',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context,
    Map<String, dynamic> resource,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: _getResourceIcon(resource['material_type']),
        title: Text(
          resource['title'] ?? 'Untitled Resource',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (resource['description'] != null)
              Text(
                resource['description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            if (resource['tutor_name'] != null)
              Text(
                'by ${resource['tutor_name']}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.download),
          onPressed: () => _handleResourceAction(context, resource),
        ),
        onTap: () => _handleResourceAction(context, resource),
      ),
    );
  }

  Widget _getResourceIcon(String? materialType) {
    switch (materialType) {
      case 'document':
        return const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.description, color: Colors.white),
        );
      case 'video':
        return const CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.video_library, color: Colors.white),
        );
      case 'link':
        return const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.link, color: Colors.white),
        );
      default:
        return const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.attachment, color: Colors.white),
        );
    }
  }

  void _handleResourceAction(
    BuildContext context,
    Map<String, dynamic> resource,
  ) {
    final fileUrl = resource['file_url'];
    final materialType = resource['material_type'];

    if (fileUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file available for this resource')),
      );
      return;
    }

    if (materialType == 'link') {
      _launchUrl(fileUrl);
    } else {
      DownloadHelper.downloadFile(
        context: context,
        url: fileUrl,
        fileName: resource['title'] ?? 'resource',
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
