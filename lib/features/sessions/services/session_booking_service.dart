import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/session_booking.dart';

final sessionBookingServiceProvider = Provider(
  (ref) => SessionBookingService(),
);

class SessionBookingService {
  final _supabase = Supabase.instance.client;

  Future<void> createBooking(SessionBooking booking) async {
    try {
      await _supabase.from('session_bookings').insert({
        'student_id': booking.studentId,
        'tutor_id': booking.tutorId,
        'start_time': booking.startTime.toIso8601String(),
        'end_time': booking.endTime.toIso8601String(),
        'topic': booking.topic,
        'notes': booking.notes,
        'status': booking.status.name,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw 'Failed to create booking: ${e.toString()}';
    }
  }

  Future<List<SessionBooking>> getStudentBookings(String studentId) async {
    try {
      final data = await _supabase
          .from('session_bookings')
          .select()
          .eq('student_id', studentId)
          .order('start_time', ascending: false);
      return data.map((json) => SessionBooking.fromJson(json)).toList();
    } catch (e) {
      throw 'Failed to get bookings: ${e.toString()}';
    }
  }

  Future<List<SessionBooking>> getTutorBookings(String tutorId) async {
    try {
      final data = await _supabase
          .from('session_bookings')
          .select()
          .eq('tutor_id', tutorId)
          .order('start_time', ascending: false);
      return data.map((json) => SessionBooking.fromJson(json)).toList();
    } catch (e) {
      throw 'Failed to get bookings: ${e.toString()}';
    }
  }

  Future<void> updateBookingStatus(
    String bookingId,
    SessionBookingStatus status,
  ) async {
    try {
      await _supabase
          .from('session_bookings')
          .update({
            'status': status.name,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', bookingId);
    } catch (e) {
      throw 'Failed to update booking status: ${e.toString()}';
    }
  }
}
