import 'package:uuid/uuid.dart';

abstract class BaseModel {
  final String id;
  final DateTime createdAt;

  BaseModel({String? id, DateTime? createdAt})
    : id = id ?? const Uuid().v4(),
      createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap();

  Map<String, dynamic> toJson() => toMap();
}
