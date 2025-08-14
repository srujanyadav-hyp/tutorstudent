import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'dart:async'; // Added for Timer

class SessionCard extends ConsumerStatefulWidget {
  final Map<String, dynamic> session;

  const SessionCard({super.key, required this.session});

  @override
  ConsumerState<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends ConsumerState<SessionCard> {
  late Timer _timer;
  late DateTime _scheduledAt;
  late DateTime _now;
  late bool _isLive;
  late bool _isUpcoming;
  late bool _isCompleted;
  late bool _isCancelled;
  late Duration _timeUntilSession;

  @override
  void initState() {
    super.initState();
    _scheduledAt = DateTime.parse(widget.session['scheduled_at']);
    _updateSessionStatus();

    // Update every minute
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          _updateSessionStatus();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateSessionStatus() {
    _now = DateTime.now();
    _isLive =
        _scheduledAt.isBefore(_now) &&
        _scheduledAt.add(const Duration(hours: 1)).isAfter(_now);
    _isUpcoming = _scheduledAt.isAfter(_now);
    _isCompleted = widget.session['status'] == 'completed';
    _isCancelled = widget.session['status'] == 'cancelled';

    if (_isUpcoming) {
      _timeUntilSession = _scheduledAt.difference(_now);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy - hh:mm a');
    final duration = Duration(minutes: widget.session['duration'] ?? 60);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: _getBorderColor(), width: 2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          context.push('/student/sessions/${widget.session['id']}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildStatusIcon(theme),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.session['title'] ?? 'Tutoring Session',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            _buildStatusBadge(theme),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.session['subject'] ?? 'General',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSessionInfo(dateFormat, duration, theme),
              const SizedBox(height: 16),
              _buildTutorInfo(theme),
              const SizedBox(height: 16),
              _buildActionButtons(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(ThemeData theme) {
    IconData icon;
    Color backgroundColor;
    Color iconColor;

    if (_isLive) {
      icon = Icons.videocam;
      backgroundColor = Colors.red.shade100;
      iconColor = Colors.red.shade700;
    } else if (_isCompleted) {
      icon = Icons.check_circle;
      backgroundColor = Colors.green.shade100;
      iconColor = Colors.green.shade700;
    } else if (_isCancelled) {
      icon = Icons.cancel;
      backgroundColor = Colors.grey.shade100;
      iconColor = Colors.grey.shade700;
    } else if (_isUpcoming) {
      icon = Icons.schedule;
      backgroundColor = Colors.blue.shade100;
      iconColor = Colors.blue.shade700;
    } else {
      icon = Icons.help;
      backgroundColor = Colors.orange.shade100;
      iconColor = Colors.orange.shade700;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }

  Widget _buildStatusBadge(ThemeData theme) {
    if (_isLive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.shade600,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'LIVE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else if (_isUpcoming && _timeUntilSession.inDays == 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.shade300),
        ),
        child: Text(
          _timeUntilSession.inHours > 0
              ? '${_timeUntilSession.inHours}h'
              : '${_timeUntilSession.inMinutes}m',
          style: TextStyle(
            color: Colors.orange.shade700,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildSessionInfo(
    DateFormat dateFormat,
    Duration duration,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 6),
            Text(
              dateFormat.format(_scheduledAt),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 6),
            Text(
              '${duration.inMinutes} minutes',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 16),
            Icon(Icons.attach_money, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 6),
            Text(
              '\$${widget.session['price'] ?? '0'}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        if (widget.session['description'] != null) ...[
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.description, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.session['description'],
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildTutorInfo(ThemeData theme) {
    final tutorName = widget.session['tutor_name'] ?? 'Unknown Tutor';
    final tutorRating = widget.session['tutor_rating'];

    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(Icons.person, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tutorName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (tutorRating != null)
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber.shade600),
                    const SizedBox(width: 4),
                    Text(
                      tutorRating.toString(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    if (_isLive) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.videocam),
          label: const Text('Join Session Now'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            context.push(
              '/student/sessions/${widget.session['id']}/live',
              extra: {'tutorId': widget.session['tutor_id']},
            );
          },
        ),
      );
    } else if (_isUpcoming) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.cancel),
              label: const Text('Cancel'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red.shade600,
                side: BorderSide(color: Colors.red.shade300),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () => _showCancelDialog(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.visibility),
              label: const Text('View Details'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                context.push('/student/sessions/${widget.session['id']}');
              },
            ),
          ),
        ],
      );
    } else if (_isCompleted) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: const Icon(Icons.rate_review),
          label: const Text('Leave Feedback'),
          style: OutlinedButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
            side: BorderSide(color: theme.colorScheme.primary),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () {
            // TODO: Navigate to feedback form
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Color _getBorderColor() {
    if (_isLive) return Colors.red.shade300;
    if (_isCompleted) return Colors.green.shade300;
    if (_isCancelled) return Colors.grey.shade300;
    if (_isUpcoming) return Colors.blue.shade300;
    return Colors.orange.shade300;
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Session'),
        content: const Text(
          'Are you sure you want to cancel this session? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Session'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement session cancellation
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Session cancelled successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cancel Session'),
          ),
        ],
      ),
    );
  }
}
