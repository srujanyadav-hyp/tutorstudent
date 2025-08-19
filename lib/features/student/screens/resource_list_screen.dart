import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/student_scaffold.dart';
import '../../../core/providers/supabase_provider.dart';

class ResourceListScreen extends ConsumerWidget {
  final String type;

  const ResourceListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StudentScaffold(
      title: type.replaceAll('-', ' ').toTitleCase(),
      currentIndex: 5,
      body: Center(child: Text('Resource list for $type')),
    );
  }
}

extension StringExtension on String {
  String toTitleCase() {
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
