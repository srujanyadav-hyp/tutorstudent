import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/user_role.dart';

final userRoleProvider = StateNotifierProvider<UserRoleNotifier, UserRole?>((
  ref,
) {
  return UserRoleNotifier();
});

class UserRoleNotifier extends StateNotifier<UserRole?> {
  UserRoleNotifier() : super(null);

  Future<void> setRole(UserRole role) async {
    state = role;
  }

  void clearRole() {
    state = null;
  }
}
