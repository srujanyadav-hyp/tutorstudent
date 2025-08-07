import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/user_role.dart';
import '../../providers/role_provider.dart';
import '../../features/auth/controller/auth_controller.dart';

class RoleSelectionScreen extends ConsumerWidget {
  final Map<String, String>? signupData;

  const RoleSelectionScreen({super.key, this.signupData});

  void _selectRole(BuildContext context, WidgetRef ref, UserRole role) async {
    if (signupData != null) {
      // This is part of the signup flow
      await ref
          .read(authControllerProvider.notifier)
          .signUp(
            context: context,
            email: signupData!['email']!,
            password: signupData!['password']!,
            fullName: signupData!['fullName']!,
            role: role,
            phone: signupData!['phone'],
          );
    } else {
      // This is role selection for an existing user
      await ref.read(userRoleProvider.notifier).setRole(role);

      if (context.mounted) {
        switch (role) {
          case UserRole.tutor:
            context.go('/tutor');
            break;
          case UserRole.student:
            context.go('/student');
            break;
          case UserRole.parent:
            context.go('/parent');
            break;
        }
      }
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
