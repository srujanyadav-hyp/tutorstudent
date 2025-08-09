import 'package:flutter/foundation.dart';

@immutable
class StudentDashboardStats {
  final int totalSessions;
  final int upcomingSessions;
  final int completedAssignments;
  final int pendingAssignments;
  final double averageScore;
  final Map<String, double> subjectPerformance;
  final List<DateTime> sessionDates;
  final List<double> progressTrend;

  const StudentDashboardStats({
    required this.totalSessions,
    required this.upcomingSessions,
    required this.completedAssignments,
    required this.pendingAssignments,
    required this.averageScore,
    required this.subjectPerformance,
    required this.sessionDates,
    required this.progressTrend,
  });

  factory StudentDashboardStats.empty() {
    return const StudentDashboardStats(
      totalSessions: 0,
      upcomingSessions: 0,
      completedAssignments: 0,
      pendingAssignments: 0,
      averageScore: 0,
      subjectPerformance: {},
      sessionDates: [],
      progressTrend: [],
    );
  }
}
