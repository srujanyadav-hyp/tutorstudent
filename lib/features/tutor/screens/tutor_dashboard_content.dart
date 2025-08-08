import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../dashboard/presentation/tutor_dashboard_view.dart';

class TutorDashboardContent extends ConsumerWidget {
  const TutorDashboardContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      return const Center(child: Text('Not authenticated'));
    }

    return TutorDashboardView(tutorId: userId);
  }
}
