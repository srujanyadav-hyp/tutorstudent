import 'package:json_annotation/json_annotation.dart';
import 'base_model.dart';

part 'message.g.dart';

@JsonSerializable()
class Message extends BaseModel {
  final String senderId;
  final String receiverId;
  final String message;
  final String? fileUrl;

  Message({
    super.id,
    super.createdAt,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.fileUrl,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'message': message,
        'file_url': fileUrl,
        'sent_at': createdAt.toIso8601String(),
      };
}
