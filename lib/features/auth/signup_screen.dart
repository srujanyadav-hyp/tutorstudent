import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'widgets/auth_form_card.dart';
import '../../core/utils/validators.dart';
import '../../providers/role_provider.dart';
import 'controller/auth_controller.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: Center(
        child: AuthFormCard(
          title: 'Sign Up',
          formKey: _formKey,
          isLoading: isLoading,
          buttonText: isLoading ? 'Creating...' : 'Next',
          onPressed: isLoading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    // Get selected role from provider
                    final role = ref.read(userRoleProvider);
                    if (role == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select your role first'),
                        ),
                      );
                      context.go('/select-role');
                      return;
                    }

                    // Process signup with the selected role
                    ref
                        .read(authControllerProvider.notifier)
                        .signUp(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                          fullName: fullNameController.text,
                          role: role,
                          phone: phoneController.text,
                        );
                  }
                },
          bottomText: "Already have an account? Login",
          onBottomPressed: () {
            context.go('/login');
          },
          children: [
            TextFormField(
              controller: fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone (Optional)'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: Validators.password,
            ),
          ],
        ),
      ),
    );
  }
}
