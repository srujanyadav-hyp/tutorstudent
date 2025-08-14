import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredTutorsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, Map<String, dynamic>>((
      ref,
      filters,
    ) async {
      final supabase = ref.read(supabaseServiceProvider);
      final query = filters['query'] as String;
      final subject = filters['subject'] as String;
      final priceRange = filters['priceRange'] as String;
      final rating = filters['rating'] as String;
      final onlineOnly = filters['onlineOnly'] as bool;

      try {
        // Build the base query
        var response = supabase.client
            .from('tutors')
            .select('*, subjects(name), ratings(rating)')
            .eq('is_verified', true);

        // Apply subject filter
        if (subject != 'All') {
          response = response.contains('subjects', [subject]);
        }

        // Apply price range filter
        if (priceRange != 'All') {
          final priceLimits = _getPriceLimits(priceRange);
          if (priceLimits != null) {
            response = response
                .gte('hourly_rate', priceLimits['min']!)
                .lte('hourly_rate', priceLimits['max']!);
          }
        }

        // Apply rating filter
        if (rating != 'All') {
          final minRating = double.tryParse(rating) ?? 0.0;
          response = response.gte('average_rating', minRating);
        }

        // Apply online only filter
        if (onlineOnly) {
          response = response.eq('is_online', true);
        }

        // Apply text search if provided
        if (query.isNotEmpty) {
          response = response.or(
            'name.ilike.%$query%,bio.ilike.%$query%,subjects.name.ilike.%$query%',
          );
        }

        final tutors = await response.order('average_rating', ascending: false);

        // Process and format the results
        return tutors.map((tutor) {
          final subjects =
              (tutor['subjects'] as List<dynamic>?)
                  ?.cast<Map<String, dynamic>>() ??
              [];
          final ratings =
              (tutor['ratings'] as List<dynamic>?)
                  ?.cast<Map<String, dynamic>>() ??
              [];

          double averageRating = 0.0;
          if (ratings.isNotEmpty) {
            final totalRating = ratings.fold<double>(
              0.0,
              (sum, rating) => sum + (rating['rating'] ?? 0.0),
            );
            averageRating = totalRating / ratings.length;
          }

          return {
            'id': tutor['id'],
            'name': tutor['name'] ?? 'Unknown Tutor',
            'bio': tutor['bio'] ?? 'No bio available',
            'avatar': tutor['avatar_url'],
            'subjects': subjects.map((s) => s['name']).toList(),
            'hourly_rate': tutor['hourly_rate'] ?? 0.0,
            'average_rating': averageRating,
            'total_sessions': tutor['total_sessions'] ?? 0,
            'is_online': tutor['is_online'] ?? false,
            'experience_years': tutor['experience_years'] ?? 0,
            'languages': tutor['languages'] ?? ['English'],
            'certifications': tutor['certifications'] ?? [],
          };
        }).toList();
      } catch (e) {
        // Return sample data for development
        return _getSampleTutors();
      }
    });

Map<String, double>? _getPriceLimits(String priceRange) {
  switch (priceRange) {
    case 'Under \$20':
      return {'min': 0, 'max': 20};
    case '\$20 - \$40':
      return {'min': 20, 'max': 40};
    case '\$40 - \$60':
      return {'min': 40, 'max': 60};
    case '\$60+':
      return {'min': 60, 'max': 1000};
    default:
      return null;
  }
}

List<Map<String, dynamic>> _getSampleTutors() {
  return [
    {
      'id': '1',
      'name': 'Dr. Sarah Johnson',
      'bio':
          'Experienced mathematics tutor with 8+ years of teaching experience. Specializes in calculus, algebra, and statistics.',
      'avatar': null,
      'subjects': ['Mathematics', 'Calculus', 'Statistics'],
      'hourly_rate': 45.0,
      'average_rating': 4.8,
      'total_sessions': 156,
      'is_online': true,
      'experience_years': 8,
      'languages': ['English', 'Spanish'],
      'certifications': ['PhD Mathematics', 'Teaching Certificate'],
    },
    {
      'id': '2',
      'name': 'Prof. Michael Chen',
      'bio':
          'Physics expert with a passion for making complex concepts simple. Available for high school and college level physics.',
      'avatar': null,
      'subjects': ['Physics', 'Mechanics', 'Thermodynamics'],
      'hourly_rate': 55.0,
      'average_rating': 4.9,
      'total_sessions': 203,
      'is_online': true,
      'experience_years': 12,
      'languages': ['English', 'Mandarin'],
      'certifications': ['PhD Physics', 'Nobel Prize Nominee'],
    },
    {
      'id': '3',
      'name': 'Emma Rodriguez',
      'bio':
          'Creative writing and literature tutor. Helps students develop their writing skills and love for reading.',
      'avatar': null,
      'subjects': ['English', 'Creative Writing', 'Literature'],
      'hourly_rate': 35.0,
      'average_rating': 4.7,
      'total_sessions': 89,
      'is_online': false,
      'experience_years': 5,
      'languages': ['English', 'Spanish'],
      'certifications': [
        'MA English Literature',
        'Creative Writing Certificate',
      ],
    },
    {
      'id': '4',
      'name': 'David Kim',
      'bio':
          'Computer science tutor specializing in programming, algorithms, and software development.',
      'avatar': null,
      'subjects': ['Computer Science', 'Python', 'Java'],
      'hourly_rate': 50.0,
      'average_rating': 4.6,
      'total_sessions': 134,
      'is_online': true,
      'experience_years': 6,
      'languages': ['English', 'Korean'],
      'certifications': ['MS Computer Science', 'Google Developer Certificate'],
    },
  ];
}
