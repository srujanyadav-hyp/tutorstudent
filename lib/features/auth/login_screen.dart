import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'widgets/auth_form_card.dart';
import '../../core/utils/validators.dart';
import 'controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: Center(
        child: AuthFormCard(
          title: 'Login',
          formKey: _formKey,
          isLoading: isLoading,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: Validators.email,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: Validators.password,
            ),
          ],
          buttonText: isLoading ? 'Logging in...' : 'Login',
          onPressed: isLoading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(authControllerProvider.notifier)
                        .login(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  }
                },
          bottomText: "Don't have an account? Sign up",
          onBottomPressed: () {
            context.go('/signup');
          },
          forgotPassword: () {
            context.go('/forgot-password');
          },
        ),
      ),
    );
  }
}
