import '../../features/tutor/models/tutor_stats.dart';

class TutorService {
  Future<TutorStats> getTutorStats(String tutorId) async {
    // TODO: Implement the actual API call to fetch tutor stats
    // For now, returning mock data
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulate network delay

    return TutorStats(
      totalSessions: 25,
      monthlyEarnings: 2500.0,
      totalStudents: 15,
      upcomingSessions: 5,
      totalEarnings: 7500.0,
      averageRating: 4.8,
      totalReviews: 20,
      sessionsPerDay: {
        'Monday': 3,
        'Tuesday': 4,
        'Wednesday': 3,
        'Thursday': 5,
        'Friday': 4,
      },
      sessionMetrics: _generateMockSessionMetrics(),
      earningMetrics: _generateMockEarningMetrics(),
    );
  }

  List<SessionMetric> _generateMockSessionMetrics() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      return SessionMetric(
        date: date,
        sessionCount: (index % 3 + 2), // Random between 2-4 sessions per day
      );
    });
  }

  List<EarningMetric> _generateMockEarningMetrics() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      return EarningMetric(
        date: date,
        amount: (index % 3 + 1) * 100.0, // Random between $100-$300 per day
      );
    });
  }
}
