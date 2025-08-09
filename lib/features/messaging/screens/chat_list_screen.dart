import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../services/messaging_service.dart';
import '../models/chat_message.dart';
import '../../../core/providers/supabase_provider.dart';

final messagingServiceProvider = Provider((ref) => MessagingService());

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: StreamBuilder<List<ChatMessage>>(
        stream: ref.read(messagingServiceProvider).getChatMessages(''),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final messages = snapshot.data!;

          // Group messages by sender/receiver to show latest conversation
          final conversations = <String, ChatMessage>{};
          for (final message in messages) {
            final otherId = message.senderId == user.id
                ? message.receiverId
                : message.senderId;

            if (!conversations.containsKey(otherId) ||
                conversations[otherId]!.createdAt.isBefore(message.createdAt)) {
              conversations[otherId] = message;
            }
          }

          if (conversations.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No messages yet',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start a conversation with your tutor/student',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final sortedConversations = conversations.entries.toList()
            ..sort((a, b) => b.value.createdAt.compareTo(a.value.createdAt));

          return ListView.builder(
            itemCount: sortedConversations.length,
            itemBuilder: (context, index) {
              final entry = sortedConversations[index];
              final otherId = entry.key;
              final lastMessage = entry.value;
              final unreadCount = messages
                  .where(
                    (m) =>
                        m.receiverId == user.id &&
                        m.senderId == otherId &&
                        !m.isRead,
                  )
                  .length;

              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: FutureBuilder<String>(
                  future: ref
                      .read(supabaseServiceProvider)
                      .getUserName(otherId),
                  builder: (context, snapshot) {
                    return Text(snapshot.data ?? 'Loading...');
                  },
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text(
                        lastMessage.message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      DateFormat.jm().format(lastMessage.createdAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                trailing: unreadCount > 0
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : null,
                onTap: () {
                  context.push('/chat/$otherId');
                },
              );
            },
          );
        },
      ),
    );
  }
}
