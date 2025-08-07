import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../models/user_role.dart';
import '../../../providers/role_provider.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  Widget _buildRoleCard(
    BuildContext context,
    WidgetRef ref, {
    required UserRole role,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () async {
          // Store selected role in provider
          await ref.read(userRoleProvider.notifier).setRole(role);
          // Navigate to signup
          if (context.mounted) {
            context.go('/signup');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 48, color: Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Choose Your Role')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text(
                'Select your role in TutorConnect',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              _buildRoleCard(
                context,
                ref,
                role: UserRole.tutor,
                title: 'Tutor',
                description: 'Share your knowledge and help students excel',
                icon: Icons.school,
              ),
              const SizedBox(height: 16),
              _buildRoleCard(
                context,
                ref,
                role: UserRole.student,
                title: 'Student',
                description: 'Learn from expert tutors and achieve your goals',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildRoleCard(
                context,
                ref,
                role: UserRole.parent,
                title: 'Parent',
                description: 'Monitor and support your child\'s education',
                icon: Icons.family_restroom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
