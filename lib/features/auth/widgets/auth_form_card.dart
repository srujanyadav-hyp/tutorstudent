import 'package:flutter/material.dart';
import '../../../core/widgets/loading_indicator.dart';

class AuthFormCard extends StatelessWidget {
  final String title;
  final GlobalKey<FormState>? formKey;
  final List<Widget> children;
  final VoidCallback? onPressed;
  final String buttonText;
  final String bottomText;
  final VoidCallback? onBottomPressed;
  final VoidCallback? forgotPassword;
  final bool isLoading;

  const AuthFormCard({
    super.key,
    required this.title,
    this.formKey,
    required this.children,
    required this.buttonText,
    this.onPressed,
    required this.bottomText,
    this.onBottomPressed,
    this.forgotPassword,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      indicatorSize: 30,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 20),
                ...children,
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(buttonText),
                  ),
                ),
                if (forgotPassword != null) ...[
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: forgotPassword,
                    child: const Text('Forgot Password?'),
                  ),
                ],
                if (bottomText.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: onBottomPressed,
                    child: Text(bottomText),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
