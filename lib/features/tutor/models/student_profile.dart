import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_profile.freezed.dart';
part 'student_profile.g.dart';

@freezed
class StudentProfile with _$StudentProfile {
  const factory StudentProfile({
    required String id,
    required String userId,
    required String fullName,
    required String email,
    String? grade,
    String? subjects,
    DateTime? joinedAt,
    String? profileImage,
    @Default(false) bool isActive,
    @Default([]) List<String> enrolledSubjects,
    @Default(0) int completedSessions,
    @Default(0) int upcomingSessions,
    @Default(0.0) double averageRating,
  }) = _StudentProfile;

  factory StudentProfile.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileFromJson(json);
}
