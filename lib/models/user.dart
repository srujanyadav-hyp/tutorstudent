import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends BaseModel {
  final String role;
  final String fullName;
  final String email;
  final String? phone;
  final String? profileImage;

  User({
    super.id,
    super.createdAt,
    required this.role,
    required this.fullName,
    required this.email,
    this.phone,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'role': role,
    'full_name': fullName,
    'email': email,
    'phone': phone,
    'profile_image': profileImage,
    'created_at': createdAt.toIso8601String(),
  };
}
