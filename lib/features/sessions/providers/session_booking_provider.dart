import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/supabase_service.dart';
import '../services/session_booking_service.dart';
import '../models/session_booking.dart';

/// Provides a list of bookings for a given student
final studentBookingsProvider =
    FutureProvider.family<List<SessionBooking>, String>((ref, studentId) async {
      final service = ref.watch(sessionBookingServiceProvider);
      return service.getStudentBookings(studentId);
    });

/// Provides a list of bookings for a given tutor
final tutorBookingsProvider =
    FutureProvider.family<List<SessionBooking>, String>((ref, tutorId) async {
      final service = ref.watch(sessionBookingServiceProvider);
      return service.getTutorBookings(tutorId);
    });

/// Controller for managing session bookings
final sessionBookingControllerProvider =
    StateNotifierProvider.family<
      SessionBookingController,
      AsyncValue<void>,
      String
    >((ref, tutorId) => SessionBookingController(ref, tutorId));

class SessionBookingController extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;
  final String _tutorId;

  SessionBookingController(this._ref, this._tutorId)
    : super(const AsyncValue.data(null));

  /// Books a new session with validation
  Future<void> bookSession({
    required DateTime startTime,
    required DateTime endTime,
    String? topic,
    String? notes,
  }) async {
    // Validate booking time
    if (startTime.isBefore(DateTime.now())) {
      state = AsyncValue.error(
        'Cannot book sessions in the past',
        StackTrace.current,
      );
      return;
    }

    if (endTime.isBefore(startTime)) {
      state = AsyncValue.error(
        'Session end time must be after start time',
        StackTrace.current,
      );
      return;
    }

    if (endTime.difference(startTime).inHours > 4) {
      state = AsyncValue.error(
        'Session duration cannot exceed 4 hours',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    try {
      final currentUser = _ref
          .read(supabaseServiceProvider)
          .client
          .auth
          .currentUser;
      if (currentUser == null) {
        state = AsyncValue.error('Not authenticated', StackTrace.current);
        return;
      }

      final booking = SessionBooking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        studentId: currentUser.id,
        tutorId: _tutorId,
        startTime: startTime,
        endTime: endTime,
        topic: topic,
        notes: notes,
        status: SessionBookingStatus.pending,
        createdAt: DateTime.now(),
      );

      await _ref.read(sessionBookingServiceProvider).createBooking(booking);

      // Invalidate providers to refresh data
      _ref.invalidate(studentBookingsProvider(currentUser.id));
      _ref.invalidate(tutorBookingsProvider(_tutorId));

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error('Failed to book session: $e', st);
    }
  }

  /// Updates the status of a booking
  Future<void> updateBookingStatus(
    String bookingId,
    SessionBookingStatus status,
  ) async {
    if (status == SessionBookingStatus.completed &&
        DateTime.now().isBefore(
          DateTime.now().subtract(const Duration(hours: 1)),
        )) {
      state = AsyncValue.error(
        'Cannot mark a session as completed before its scheduled end time',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    try {
      final currentUser = _ref
          .read(supabaseServiceProvider)
          .client
          .auth
          .currentUser;
      if (currentUser == null) {
        state = AsyncValue.error('Not authenticated', StackTrace.current);
        return;
      }

      await _ref
          .read(sessionBookingServiceProvider)
          .updateBookingStatus(bookingId, status);

      // Invalidate providers to refresh data
      _ref.invalidate(studentBookingsProvider(currentUser.id));
      _ref.invalidate(tutorBookingsProvider(_tutorId));

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error('Failed to update booking status: $e', st);
    }
  }
}
