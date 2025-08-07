import 'package:hive/hive.dart';

part 'user_role.g.dart';

@HiveType(typeId: 0)
enum UserRole {
  @HiveField(0)
  student,

  @HiveField(1)
  tutor,

  @HiveField(2)
  parent,
}
