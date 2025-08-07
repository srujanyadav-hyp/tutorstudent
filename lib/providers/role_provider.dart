import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../models/user_role.dart';

final roleBoxProvider = Provider<Box<UserRole>>((ref) {
  throw UnimplementedError(); // Will be overridden in main.dart
});

final userRoleProvider = StateNotifierProvider<UserRoleNotifier, UserRole?>((
  ref,
) {
  final box = ref.watch(roleBoxProvider);
  return UserRoleNotifier(box);
});

class UserRoleNotifier extends StateNotifier<UserRole?> {
  final Box<UserRole> _box;

  UserRoleNotifier(this._box) : super(_box.get('role'));

  Future<void> setRole(UserRole role) async {
    await _box.put('role', role);
    state = role;
  }

  Future<void> clearRole() async {
    await _box.delete('role');
    state = null;
  }
}
