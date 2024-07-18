// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plot_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlotAdapter extends TypeAdapter<Plot> {
  @override
  final int typeId = 0;

  @override
  Plot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plot(
      acreage: fields[0] as num?,
      description: fields[1] as String?,
      district: fields[2] as String?,
      id: fields[3] as String?,
      images: (fields[4] as List?)?.cast<dynamic>(),
      location: fields[5] as GeoPoint?,
      name: fields[6] as String?,
      price: fields[7] as int?,
      status: fields[8] as String?,
      myUser: fields[9] as MyUserEntity?,
      appointment: fields[10] as String?,
      divisibility: fields[11] as String?,
      isFavorite: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Plot obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.acreage)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.district)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.images)
      ..writeByte(5)
      ..write(obj.location)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.myUser)
      ..writeByte(10)
      ..write(obj.appointment)
      ..writeByte(11)
      ..write(obj.divisibility)
      ..writeByte(12)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
