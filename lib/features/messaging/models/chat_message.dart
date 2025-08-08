// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

/// ChatMessage represents a single message in a chat conversation.
/// It includes information about the sender, receiver, message content,
/// timestamp, and read status.
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    /// Unique identifier for the message
    required String id,

    /// ID of the user who sent the message
    @JsonKey(name: 'sender_id') required String senderId,

    /// ID of the user who will receive the message
    @JsonKey(name: 'receiver_id') required String receiverId,

    /// The actual message content
    required String message,

    /// Timestamp when the message was created
    @JsonKey(name: 'created_at') required DateTime createdAt,

    /// Whether the message has been read by the receiver
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
  }) = _ChatMessage;

  /// Creates a ChatMessage instance from a JSON map
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  /// Additional constructor for creating a new message
  factory ChatMessage.create({
    required String senderId,
    required String receiverId,
    required String message,
  }) => ChatMessage(
    id: DateTime.now().toIso8601String(), // Use timestamp as temporary ID
    senderId: senderId,
    receiverId: receiverId,
    message: message,
    createdAt: DateTime.now(),
    isRead: false,
  );
}
