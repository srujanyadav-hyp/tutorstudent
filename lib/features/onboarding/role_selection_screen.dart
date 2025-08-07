import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/user_role.dart';
import '../../providers/role_provider.dart';
import '../../core/services/auth_service.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  void _selectRole(BuildContext context, WidgetRef ref, UserRole role) async {
    // Store selected role in provider
    await ref.read(userRoleProvider.notifier).setRole(role);

    // After role selection, go to signup for new users
    if (context.mounted) {
      context.go('/signup');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Role')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose your role to continue',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _selectRole(context, ref, UserRole.tutor),
              child: const Text('I am a Tutor'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectRole(context, ref, UserRole.student),
              child: const Text('I am a Student'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectRole(context, ref, UserRole.parent),
              child: const Text('I am a Parent'),
            ),
          ],
        ),
      ),
    );
  }
}
