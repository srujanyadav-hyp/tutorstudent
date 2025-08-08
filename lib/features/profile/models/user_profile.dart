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
      id: json['id']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      phone: json['phone']?.toString(),
      bio: json['bio']?.toString(),
      profileImage: json['profile_image']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'].toString())
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'].toString())
          : DateTime.now(),
      roleSpecificData: json['role_specific_data'] is Map
          ? Map<String, dynamic>.from(json['role_specific_data'])
          : null,
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
