import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/student_management_provider.dart';
import '../services/student_management_service.dart';
import '../widgets/edit_student_dialog.dart';
import '../widgets/student_list_item.dart';

class StudentListScreen extends ConsumerWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabase = ref.watch(supabaseServiceProvider);
    final user = supabase.client.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final studentsAsync = ref.watch(managedStudentsProvider(user.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const EditStudentDialog(),
              );
            },
          ),
        ],
      ),
      body: studentsAsync.when(
        data: (students) {
          if (students.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64,
                    color: Theme.of(context).disabledColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No students yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start adding students to manage them',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return StudentListItem(
                student: student,
                onTap: () {
                  context.go('/tutor/student/${student.id}', extra: student);
                },
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditStudentDialog(student: student),
                  );
                },
                onRemove: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Remove Student'),
                      content: Text(
                        'Are you sure you want to remove ${student.name}? '
                        'This action cannot be undone.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(studentManagementServiceProvider)
                                .removeStudent(student.id);
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          child: const Text('REMOVE'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Error loading students',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final refresh = ref.refresh(
                    managedStudentsProvider(user.id).future,
                  );
                  refresh
                      .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Student list refreshed'),
                          ),
                        );
                      })
                      .catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $error'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                },
                child: const Text('RETRY'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
