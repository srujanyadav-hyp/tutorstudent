import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends BaseModel {
  final String role;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String email;
  final String? phone;
  @JsonKey(name: 'profile_image')
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
}
