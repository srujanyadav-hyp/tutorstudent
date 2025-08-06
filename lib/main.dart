import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(MyApp(userRole: UserRole.student));
}

class MyApp extends StatelessWidget {
  final UserRole userRole;

  MyApp({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TutorConnect',
      theme: RoleTheme.getTheme(userRole),
      debugShowCheckedModeBanner: false,
      home: Placeholder(),
    );
  }
}
