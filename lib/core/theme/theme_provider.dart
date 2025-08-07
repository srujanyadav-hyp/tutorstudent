import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorconnect/models/user_role.dart';
import 'package:tutorconnect/providers/role_provider.dart';
import 'app_theme.dart';

// Theme mode provider (light/dark)
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((
  ref,
) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.light);

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

// Current theme provider that combines role and theme mode
final currentThemeProvider = Provider<ThemeData>((ref) {
  final userRole = ref.watch(userRoleProvider);
  final themeMode = ref.watch(themeModeProvider);

  // Default to student role if no role is selected
  final role = userRole ?? UserRole.student;

  // For now, we'll use the role-based theme
  // You can extend this to support dark themes later
  return RoleTheme.getTheme(role);
});

// Theme provider class for easier access to theme-related functionality
class AppThemeProvider {
  static ThemeData getThemeForRole(UserRole role, {bool isDark = false}) {
    // Currently only light themes are implemented
    // You can extend this to support dark themes
    return RoleTheme.getTheme(role);
  }

  static Color getPrimaryColorForRole(UserRole role) {
    switch (role) {
      case UserRole.student:
        return const Color(0xFF8B4513);
      case UserRole.tutor:
        return const Color(0xFF90EE90);
      case UserRole.parent:
        return Colors.indigo;
    }
  }

  static Color getBackgroundColorForRole(UserRole role) {
    switch (role) {
      case UserRole.student:
        return const Color(0xFFFFF8DC);
      case UserRole.tutor:
        return const Color(0xFFFFFAFA);
      case UserRole.parent:
        return Colors.white;
    }
  }
}
