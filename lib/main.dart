import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/user_role.dart';
import 'providers/role_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/config/env_config.dart';
import 'config/router/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
  );

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(UserRoleAdapter());
  final settingsBox = await Hive.openBox<UserRole>('settings');

  // Create a ProviderContainer with overrides
  final container = ProviderContainer(
    overrides: [roleBoxProvider.overrideWithValue(settingsBox)],
  );
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(userRoleProvider);

    return MaterialApp.router(
      title: 'TutorConnect',
      theme: userRole != null
          ? RoleTheme.getTheme(userRole)
          : RoleTheme.getTheme(UserRole.student),
      routerConfig: ref.watch(goRouterProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
