import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../models/user_role.dart';
import '../models/onboarding_data.dart';

class RoleOnboardingScreen extends ConsumerStatefulWidget {
  final UserRole role;

  const RoleOnboardingScreen({super.key, required this.role});

  @override
  ConsumerState<RoleOnboardingScreen> createState() =>
      _RoleOnboardingScreenState();
}

class _RoleOnboardingScreenState extends ConsumerState<RoleOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late List<OnboardingData> _onboardingData;

  @override
  void initState() {
    super.initState();
    _onboardingData = _getOnboardingData();
  }

  List<OnboardingData> _getOnboardingData() {
    switch (widget.role) {
      case UserRole.tutor:
        return TutorOnboardingData.items;
      case UserRole.student:
        return StudentOnboardingData.items;
      case UserRole.parent:
        return ParentOnboardingData.items;
    }
  }

  void _onNextPressed() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to the appropriate dashboard
      switch (widget.role) {
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

  void _onSkip() {
    // Navigate to the appropriate dashboard
    switch (widget.role) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            data.imageAsset,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          data.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          data.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: _onSkip, child: const Text('Skip')),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _onNextPressed,
                    child: Text(
                      _currentPage == _onboardingData.length - 1
                          ? 'Get Started'
                          : 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
