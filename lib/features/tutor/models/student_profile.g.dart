// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentProfileImpl _$$StudentProfileImplFromJson(Map<String, dynamic> json) =>
    _$StudentProfileImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      grade: json['grade'] as String?,
      subjects: json['subjects'] as String?,
      joinedAt: json['joinedAt'] == null
          ? null
          : DateTime.parse(json['joinedAt'] as String),
      profileImage: json['profileImage'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      enrolledSubjects: (json['enrolledSubjects'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      completedSessions: (json['completedSessions'] as num?)?.toInt() ?? 0,
      upcomingSessions: (json['upcomingSessions'] as num?)?.toInt() ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$StudentProfileImplToJson(
        _$StudentProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'email': instance.email,
      'grade': instance.grade,
      'subjects': instance.subjects,
      'joinedAt': instance.joinedAt?.toIso8601String(),
      'profileImage': instance.profileImage,
      'isActive': instance.isActive,
      'enrolledSubjects': instance.enrolledSubjects,
      'completedSessions': instance.completedSessions,
      'upcomingSessions': instance.upcomingSessions,
      'averageRating': instance.averageRating,
    };
