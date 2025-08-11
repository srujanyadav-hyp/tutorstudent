import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/live_session_service.dart';

class ParticipantControls extends ConsumerStatefulWidget {
  final String sessionId;
  final bool isTutor;
  final Map<String, bool> participantStates;

  const ParticipantControls({
    super.key,
    required this.sessionId,
    required this.isTutor,
    required this.participantStates,
  });

  @override
  ConsumerState<ParticipantControls> createState() =>
      _ParticipantControlsState();
}

class _ParticipantControlsState extends ConsumerState<ParticipantControls> {
  bool _isSharingScreen = false;
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _toggleScreenShare() async {
    final liveSessionService = ref.read(liveSessionServiceProvider);
    try {
      await liveSessionService.updateScreenShare(
        widget.sessionId,
        _isSharingScreen ? null : 'screen_share_url', // Replace with actual URL
      );
      setState(() => _isSharingScreen = !_isSharingScreen);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Participant list
          Expanded(
            flex: 2,
            child: ListView(
              children: widget.participantStates.entries.map((entry) {
                return ListTile(
                  leading: Icon(
                    Icons.person,
                    color: entry.value ? Colors.green : Colors.grey,
                  ),
                  title: Text('User ${entry.key}'),
                  subtitle: Text(entry.value ? 'Online' : 'Offline'),
                );
              }).toList(),
            ),
          ),

          // Controls
          if (widget.isTutor)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: _toggleScreenShare,
                    icon: Icon(
                      _isSharingScreen
                          ? Icons.stop_screen_share
                          : Icons.screen_share,
                    ),
                    label: Text(
                      _isSharingScreen ? 'Stop Sharing' : 'Share Screen',
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

          // Chat input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      // TODO: Implement chat functionality
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
