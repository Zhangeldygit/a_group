import 'package:cloud_firestore/cloud_firestore.dart';

class PlotEntity {
  num? acreage;
  String? description;
  String? district;
  String? id;
  String? userId;
  List<dynamic>? images;
  GeoPoint? location;
  String? name;
  int? price;
  String? status;
  String? userName;

  PlotEntity({
    required this.acreage,
    required this.description,
    required this.district,
    this.id,
    this.userId,
    required this.images,
    required this.location,
    required this.name,
    required this.price,
    required this.status,
    required this.userName,
  });

  Map<String, Object?> toDocument() {
    return {
      'acreage': acreage,
      'description': description,
      'district': district,
      'id': id,
      'user_id': userId,
      'images': images,
      'location': location,
      'name': name,
      'price': price,
      'status': status,
      'user_name': userName,
    };
  }

  static PlotEntity fromDocument(Map<String, dynamic> doc) {
    return PlotEntity(
      acreage: doc['acreage'],
      description: doc['description'],
      district: doc['district'],
      id: doc['id'],
      images: doc['images'],
      location: doc['location'],
      name: doc['name'],
      price: doc['price'],
      status: doc['status'],
      userName: doc['user_name'],
    );
  }
}
