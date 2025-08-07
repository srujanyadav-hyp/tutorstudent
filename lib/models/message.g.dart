// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      message: json['message'] as String,
      fileUrl: json['fileUrl'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'message': instance.message,
      'fileUrl': instance.fileUrl,
    };
