// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyUserAdapter extends TypeAdapter<MyUser> {
  @override
  final int typeId = 3;

  @override
  MyUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyUser(
      userId: fields[0] as String,
      email: fields[1] as String,
      name: fields[2] as String,
      phone: fields[3] as String,
      hasActiveCart: fields[4] as bool,
      userType: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyUser obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.hasActiveCart)
      ..writeByte(5)
      ..write(obj.userType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
