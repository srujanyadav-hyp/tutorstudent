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

class UserRoleAdapter extends TypeAdapter<UserRole> {
  @override
  final int typeId = 0;

  @override
  UserRole read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserRole.student;
      case 1:
        return UserRole.tutor;
      case 2:
        return UserRole.parent;
      default:
        return UserRole.student;
    }
  }

  @override
  void write(BinaryWriter writer, UserRole obj) {
    switch (obj) {
      case UserRole.student:
        writer.writeByte(0);
        break;
      case UserRole.tutor:
        writer.writeByte(1);
        break;
      case UserRole.parent:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
