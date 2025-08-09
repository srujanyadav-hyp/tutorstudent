import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  factory ChatMessage({
    required String id,
    required String senderId,
    required String receiverId,
    required String content,
    required DateTime timestamp,
    required bool isRead,
    String? attachmentUrl,
    String? attachmentType,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}
}
