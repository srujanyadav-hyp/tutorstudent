import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final searchServiceProvider = Provider((ref) => SearchService());

class SearchService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> searchTutors({
    String? query,
    List<String>? subjects,
    String? availability,
    double? minRating,
    String? sortBy,
  }) async {
    try {
      var queryBuilder = _supabase
          .from('user_profiles')
          .select('''
            id,
            full_name,
            email,
            bio,
            profile_image,
            role_specific_data,
            tutor_availability(day_of_week, start_time, end_time),
            tutor_subjects(subject_name),
            tutor_reviews(rating, feedback)
          ''')
          .eq('role', 'tutor');

      if (query != null && query.isNotEmpty) {
        queryBuilder = queryBuilder.ilike('full_name', '%$query%');
      }

      if (subjects != null && subjects.isNotEmpty) {
        queryBuilder = queryBuilder.filter(
          'tutor_subjects.subject_name',
          'in',
          subjects,
        );
      }

      final response = await queryBuilder;
      var tutors = List<Map<String, dynamic>>.from(response);

      // Client-side filtering for complex conditions
      tutors = tutors.where((tutor) {
        final reviews = tutor['tutor_reviews'] as List;
        final avgRating = reviews.isEmpty
            ? 0.0
            : reviews.map((r) => r['rating'] as num).reduce((a, b) => a + b) /
                  reviews.length;

        bool meetsRatingCriteria = minRating == null || avgRating >= minRating;

        bool meetsAvailabilityCriteria = true;
        if (availability != null) {
          final availabilitySlots = tutor['tutor_availability'] as List;
          meetsAvailabilityCriteria = availabilitySlots.any(
            (slot) => slot['day_of_week'] == availability,
          );
        }

        return meetsRatingCriteria && meetsAvailabilityCriteria;
      }).toList();

      // Sorting
      if (sortBy != null) {
        switch (sortBy) {
          case 'rating':
            tutors.sort((a, b) {
              final aReviews = a['tutor_reviews'] as List;
              final bReviews = b['tutor_reviews'] as List;
              final aRating = aReviews.isEmpty
                  ? 0.0
                  : aReviews
                            .map((r) => r['rating'] as num)
                            .reduce((x, y) => x + y) /
                        aReviews.length;
              final bRating = bReviews.isEmpty
                  ? 0.0
                  : bReviews
                            .map((r) => r['rating'] as num)
                            .reduce((x, y) => x + y) /
                        bReviews.length;
              return bRating.compareTo(aRating);
            });
            break;
          case 'name':
            tutors.sort(
              (a, b) => (a['full_name'] as String).compareTo(
                b['full_name'] as String,
              ),
            );
            break;
        }
      }

      return tutors;
    } catch (e) {
      throw 'Failed to search tutors: ${e.toString()}';
    }
  }

  Future<List<Map<String, dynamic>>> searchSessions({
    String? tutorName,
    String? subject,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) async {
    try {
      var queryBuilder = _supabase.from('class_sessions').select('''
        *,
        tutor:tutor_id(
          full_name,
          profile_image
        ),
        student_class_attendance(
          student_id,
          attendance_status
        )
      ''');

      if (tutorName != null && tutorName.isNotEmpty) {
        queryBuilder = queryBuilder.ilike('tutor.full_name', '%$tutorName%');
      }

      if (subject != null && subject.isNotEmpty) {
        queryBuilder = queryBuilder.eq('subject', subject);
      }

      if (startDate != null) {
        queryBuilder = queryBuilder.gte(
          'scheduled_at',
          startDate.toIso8601String(),
        );
      }

      if (endDate != null) {
        queryBuilder = queryBuilder.lte(
          'scheduled_at',
          endDate.toIso8601String(),
        );
      }

      if (status != null && status.isNotEmpty) {
        queryBuilder = queryBuilder.eq('status', status);
      }

      final response = await queryBuilder.order(
        'scheduled_at',
        ascending: true,
      );
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw 'Failed to search sessions: ${e.toString()}';
    }
  }

  Future<List<Map<String, dynamic>>> searchAssignments({
    String? query,
    String? subject,
    String? status,
    DateTime? dueAfter,
    DateTime? dueBefore,
  }) async {
    try {
      var queryBuilder = _supabase.from('assignments').select('''
        *,
        tutor:tutor_id(
          full_name,
          profile_image
        ),
        assignment_submissions(
          student_id,
          submitted_at,
          score
        )
      ''');

      if (query != null && query.isNotEmpty) {
        queryBuilder = queryBuilder.or(
          'title.ilike.%$query%,description.ilike.%$query%',
        );
      }

      if (subject != null && subject.isNotEmpty) {
        queryBuilder = queryBuilder.eq('subject', subject);
      }

      if (dueAfter != null) {
        queryBuilder = queryBuilder.gte('due_date', dueAfter.toIso8601String());
      }

      if (dueBefore != null) {
        queryBuilder = queryBuilder.lte(
          'due_date',
          dueBefore.toIso8601String(),
        );
      }

      final response = await queryBuilder.order('due_date', ascending: true);
      var assignments = List<Map<String, dynamic>>.from(response);

      // Filter by submission status if requested
      if (status != null && status.isNotEmpty) {
        assignments = assignments.where((assignment) {
          final submissions = assignment['assignment_submissions'] as List;
          switch (status) {
            case 'submitted':
              return submissions.isNotEmpty;
            case 'pending':
              return submissions.isEmpty;
            case 'graded':
              return submissions.any((s) => s['score'] != null);
            default:
              return true;
          }
        }).toList();
      }

      return assignments;
    } catch (e) {
      throw 'Failed to search assignments: ${e.toString()}';
    }
  }
}
