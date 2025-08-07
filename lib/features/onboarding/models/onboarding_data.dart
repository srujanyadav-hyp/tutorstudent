class OnboardingData {
  final String title;
  final String description;
  final String imageAsset;
  final Map<String, dynamic>? additionalData;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imageAsset,
    this.additionalData,
  });
}

class TutorOnboardingData extends OnboardingData {
  TutorOnboardingData({
    required String title,
    required String description,
    required String imageAsset,
    Map<String, dynamic>? additionalData,
  }) : super(
         title: title,
         description: description,
         imageAsset: imageAsset,
         additionalData: additionalData,
       );

  static List<OnboardingData> items = [
    OnboardingData(
      title: 'Welcome to TutorConnect',
      description:
          'Start your journey as a tutor and help students excel in their studies.',
      imageAsset: 'assets/images/tutor_welcome.png',
    ),
    OnboardingData(
      title: 'Create Your Schedule',
      description:
          'Set your availability and manage your teaching hours efficiently.',
      imageAsset: 'assets/images/tutor_schedule.png',
    ),
    OnboardingData(
      title: 'Connect with Students',
      description:
          'Find students that match your expertise and start teaching.',
      imageAsset: 'assets/images/tutor_connect.png',
    ),
  ];
}

class StudentOnboardingData extends OnboardingData {
  StudentOnboardingData({
    required String title,
    required String description,
    required String imageAsset,
    Map<String, dynamic>? additionalData,
  }) : super(
         title: title,
         description: description,
         imageAsset: imageAsset,
         additionalData: additionalData,
       );

  static List<OnboardingData> items = [
    OnboardingData(
      title: 'Welcome to TutorConnect',
      description: 'Start your learning journey with expert tutors.',
      imageAsset: 'assets/images/student_welcome.png',
    ),
    OnboardingData(
      title: 'Find Your Perfect Tutor',
      description:
          'Browse through qualified tutors and find the perfect match for your needs.',
      imageAsset: 'assets/images/student_search.png',
    ),
    OnboardingData(
      title: 'Track Your Progress',
      description: 'Monitor your learning progress and achieve your goals.',
      imageAsset: 'assets/images/student_progress.png',
    ),
  ];
}

class ParentOnboardingData extends OnboardingData {
  ParentOnboardingData({
    required String title,
    required String description,
    required String imageAsset,
    Map<String, dynamic>? additionalData,
  }) : super(
         title: title,
         description: description,
         imageAsset: imageAsset,
         additionalData: additionalData,
       );

  static List<OnboardingData> items = [
    OnboardingData(
      title: 'Welcome to TutorConnect',
      description: 'Monitor and support your child\'s learning journey.',
      imageAsset: 'assets/images/parent_welcome.png',
    ),
    OnboardingData(
      title: 'Track Performance',
      description: 'Stay updated with your child\'s progress and achievements.',
      imageAsset: 'assets/images/parent_track.png',
    ),
    OnboardingData(
      title: 'Connect with Tutors',
      description:
          'Communicate directly with tutors and stay involved in your child\'s education.',
      imageAsset: 'assets/images/parent_connect.png',
    ),
  ];
}
