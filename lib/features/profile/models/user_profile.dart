import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String? phone;
  final String? bio;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? roleSpecificData;

  const UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.phone,
    this.bio,
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    this.roleSpecificData,
  });

  UserProfile copyWith({
    String? fullName,
    String? phone,
    String? bio,
    String? profileImage,
    Map<String, dynamic>? roleSpecificData,
  }) {
    return UserProfile(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email,
      role: role,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      roleSpecificData: roleSpecificData ?? this.roleSpecificData,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      phone: json['phone']?.toString() ?? '',
      bio: json['bio']?.toString() ?? '',
      profileImage: json['profile_image']?.toString(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      roleSpecificData:
          (json['role_specific_data'] as Map<String, dynamic>?) ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'role': role,
      'phone': phone,
      'bio': bio,
      'profile_image': profileImage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'role_specific_data': roleSpecificData,
    };
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, fullName: $fullName, email: $email, role: $role)';
  }
}
