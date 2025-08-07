import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/auth_form_card.dart';
import '../../../core/utils/validators.dart';
import '../controller/auth_controller.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: Center(
        child: AuthFormCard(
          title: 'Forgot Password',
          formKey: _formKey,
          isLoading: isLoading,
          buttonText: isLoading ? 'Sending...' : 'Send Reset Link',
          bottomText: 'Back to Login',
          onBottomPressed: () => context.go('/login'),
          onPressed: isLoading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(authControllerProvider.notifier)
                        .resetPassword(
                          context: context,
                          email: emailController.text,
                        );
                  }
                },
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: Validators.email,
            ),
          ],
        ),
      ),
    );
  }
}
