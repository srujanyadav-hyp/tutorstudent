import 'package:flutter/material.dart';
import 'package:tutorconnect/models/user_role.dart';

class AppTheme {
  static ThemeData get lightTheme => RoleTheme.getTheme(UserRole.student);
  static ThemeData get darkTheme =>
      RoleTheme.getTheme(UserRole.student); // You can customize this later
}

class RoleTheme {
  static ThemeData getTheme(UserRole role) {
    switch (role) {
      case UserRole.student:
        return _buildTheme(
          seedColor: const Color(0xFF8B4513),
          backgroundColor: const Color(0xFFFFF8DC),
          secondaryColor: Colors.brown.shade300,
        );

      case UserRole.tutor:
        return _buildTheme(
          seedColor: const Color(0xFF90EE90),
          backgroundColor: const Color(0xFFFFFAFA),
          secondaryColor: Colors.green.shade300,
        );

      case UserRole.parent:
        return _buildTheme(
          seedColor: Colors.indigo,
          backgroundColor: Colors.white,
          secondaryColor: Colors.indigo.shade200,
        );
    }
  }

  static ThemeData _buildTheme({
    required Color seedColor,
    required Color backgroundColor,
    required Color secondaryColor,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      background: backgroundColor,
    ).copyWith(secondary: secondaryColor);

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: seedColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 16),
        labelLarge: TextStyle(fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: seedColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: seedColor,
          side: BorderSide(color: seedColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
        labelStyle: TextStyle(color: colorScheme.onSurface),
      ),
    );
  }
}
