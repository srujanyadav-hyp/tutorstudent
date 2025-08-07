import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorHandler {
  static String getMessage(dynamic error) {
    if (error is AuthException) {
      return _getAuthErrorMessage(error);
    } else if (error is PostgrestException) {
      return _getDatabaseErrorMessage(error);
    } else {
      return error.toString();
    }
  }

  static String _getAuthErrorMessage(AuthException error) {
    switch (error.message) {
      case 'Invalid login credentials':
        return 'Invalid email or password';
      case 'Email not confirmed':
        return 'Please verify your email address';
      case 'User already registered':
        return 'An account with this email already exists';
      case 'Password should be at least 6 characters':
        return 'Password must be at least 6 characters';
      case 'Invalid email':
        return 'Please enter a valid email address';
      default:
        return error.message;
    }
  }

  static String _getDatabaseErrorMessage(PostgrestException error) {
    if (error.code == 'PGRST116') {
      return 'Resource not found';
    } else if (error.code == '23505') {
      return 'This record already exists';
    } else if (error.code == '23503') {
      return 'Related record not found';
    } else {
      return 'Database error: ${error.message}';
    }
  }
}
