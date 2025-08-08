import 'package:uuid/uuid.dart';

import 'package:json_annotation/json_annotation.dart';

abstract class BaseModel {
  final String id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  BaseModel({String? id, DateTime? createdAt})
    : id = id ?? const Uuid().v4(),
      createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson();
}
