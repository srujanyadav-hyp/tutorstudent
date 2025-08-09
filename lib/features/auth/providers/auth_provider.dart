import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider = Provider((ref) => Supabase.instance.client.auth);

final currentUserProvider = StateProvider<User?>((ref) {
  return ref.watch(authProvider).currentUser;
});
