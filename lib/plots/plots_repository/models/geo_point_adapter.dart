import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GeoPointAdapter extends TypeAdapter<GeoPoint> {
  @override
  final typeId = 1;

  @override
  GeoPoint read(BinaryReader reader) {
    final latitude = reader.readDouble();
    final longitude = reader.readDouble();
    return GeoPoint(latitude, longitude);
  }

  @override
  void write(BinaryWriter writer, GeoPoint obj) {
    writer.writeDouble(obj.latitude);
    writer.writeDouble(obj.longitude);
  }
}
