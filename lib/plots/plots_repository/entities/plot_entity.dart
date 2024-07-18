import 'package:a_group/auth/auth_repository/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlotEntity {
  num? acreage;
  String? description;
  String? district;
  String? id;
  List<dynamic>? images;
  GeoPoint? location;
  String? name;
  int? price;
  String? status;
  MyUserEntity? myUser;
  String? appointment;
  String? divisibility;

  PlotEntity({
    required this.acreage,
    required this.description,
    required this.district,
    this.id,
    required this.images,
    required this.location,
    required this.name,
    required this.price,
    required this.status,
    this.myUser,
    this.appointment,
    this.divisibility,
  });

  Map<String, Object?> toDocument() {
    return {
      'acreage': acreage,
      'description': description,
      'district': district,
      'id': id,
      'images': images,
      'location': location,
      'name': name,
      'price': price,
      'status': status,
      'user': myUser?.toDocument(),
      'appointment': appointment,
      'divisibility': divisibility,
    };
  }

  static PlotEntity fromDocument(Map<String, dynamic> doc, {String? id}) {
    return PlotEntity(
      acreage: doc['acreage'],
      description: doc['description'],
      district: doc['district'],
      id: id ?? '',
      images: doc['images'],
      location: doc['location'],
      name: doc['name'],
      price: doc['price'],
      status: doc['status'],
      myUser: MyUserEntity.fromDocument(doc['user']),
      appointment: doc['appointment'],
      divisibility: doc['divisibility'],
    );
  }
}
