import 'package:go_router/go_router.dart';
import '../screens/chat_list_screen.dart';
import '../screens/chat_detail_screen.dart';

final chatRoutes = [
  GoRoute(path: '/chats', builder: (context, state) => const ChatListScreen()),
  GoRoute(
    path: '/chat/:userId',
    builder: (context, state) {
      final userId = state.pathParameters['userId']!;
      final extra = state.extra as Map<String, dynamic>?;
      return ChatDetailScreen(
        otherUserId: userId,
        userName: extra?['userName'] as String?,
        userImage: extra?['userImage'] as String?,
      );
    },
  ),
];
