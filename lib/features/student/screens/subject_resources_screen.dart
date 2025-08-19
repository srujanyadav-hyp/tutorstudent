import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/student_scaffold.dart';

class SubjectResourcesScreen extends ConsumerWidget {
  final String subjectId;

  const SubjectResourcesScreen({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StudentScaffold(
      title: subjectId.replaceAll('-', ' ').toTitleCase(),
      currentIndex: 5,
      body: Center(
        child: Text(
          'Resources for ${subjectId.replaceAll('-', ' ').toTitleCase()}',
        ),
      ),
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
