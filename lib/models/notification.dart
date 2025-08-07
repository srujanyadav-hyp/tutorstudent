import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification extends BaseModel {
  final String userId;
  final String title;
  final String body;
  final bool read;

  Notification({
    super.id,
    super.createdAt,
    required this.userId,
    required this.title,
    required this.body,
    this.read = false,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'title': title,
        'body': body,
        'read': read,
        'created_at': createdAt.toIso8601String(),
      };

  Notification copyWith({
    bool? read,
  }) {
    return Notification(
      id: id,
      userId: userId,
      title: title,
      body: body,
      read: read ?? this.read,
      createdAt: createdAt,
    );
  }
}
