import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/live_session.dart';
import '../services/live_session_service.dart';
import '../widgets/whiteboard.dart';
import '../widgets/screen_share_view.dart';
import '../widgets/participant_controls.dart';

class LiveSessionScreen extends ConsumerStatefulWidget {
  final String sessionId;
  final String tutorId;
  final String studentId;
  final bool isTutor;

  const LiveSessionScreen({
    super.key,
    required this.sessionId,
    required this.tutorId,
    required this.studentId,
    required this.isTutor,
  });

  @override
  ConsumerState<LiveSessionScreen> createState() => _LiveSessionScreenState();
}

class _LiveSessionScreenState extends ConsumerState<LiveSessionScreen> {
  late LiveSession? _liveSession;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSession();
  }

  Future<void> _initializeSession() async {
    final liveSessionService = ref.read(liveSessionServiceProvider);

    try {
      // Check if there's an existing active session
      _liveSession = await liveSessionService.getCurrentLiveSession(
        widget.sessionId,
      );

      // If no active session and user is tutor, create one
      if (_liveSession == null && widget.isTutor) {
        _liveSession = await liveSessionService.startSession(
          widget.sessionId,
          widget.tutorId,
          widget.studentId,
        );
      }

      // Update participant state
      if (_liveSession != null) {
        await liveSessionService.updateParticipantState(
          _liveSession!.id,
          widget.isTutor ? widget.tutorId : widget.studentId,
          true,
        );
      }

      setState(() => _isLoading = false);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  void dispose() {
    if (_liveSession != null) {
      ref
          .read(liveSessionServiceProvider)
          .updateParticipantState(
            _liveSession!.id,
            widget.isTutor ? widget.tutorId : widget.studentId,
            false,
          );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_liveSession == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Waiting for tutor to start the session...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Session'),
        actions: [
          if (widget.isTutor)
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () async {
                try {
                  await ref
                      .read(liveSessionServiceProvider)
                      .endSession(_liveSession!.id);
                  if (mounted) Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              },
            ),
        ],
      ),
      body: StreamBuilder<LiveSession>(
        stream: ref
            .read(liveSessionServiceProvider)
            .streamLiveSession(_liveSession!.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final session = snapshot.data!;

          if (session.status == LiveSessionStatus.ended) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
            return const SizedBox();
          }

          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Main content area (whiteboard or screen share)
                    Expanded(
                      flex: 3,
                      child: session.screenShareUrl != null
                          ? ScreenShareView(url: session.screenShareUrl!)
                          : Whiteboard(
                              sessionId: session.id,
                              initialData: session.whiteboardData,
                              isEditable: widget.isTutor,
                            ),
                    ),
                    // Participant controls and chat
                    Expanded(
                      child: ParticipantControls(
                        sessionId: session.id,
                        isTutor: widget.isTutor,
                        participantStates: session.participantStates,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
