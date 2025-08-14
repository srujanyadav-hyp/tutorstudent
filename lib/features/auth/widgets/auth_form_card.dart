import 'package:flutter/material.dart';

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
    return Stack(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    ...children,
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : onPressed,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (forgotPassword != null) ...[
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: isLoading ? null : forgotPassword,
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                    if (bottomText.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: isLoading ? null : onBottomPressed,
                        child: Text(bottomText),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
