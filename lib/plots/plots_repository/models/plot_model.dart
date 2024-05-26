import 'package:a_group/plots/plots_repository/entities/plot_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Plot {
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

  Plot({
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

  PlotEntity toEntity() {
    return PlotEntity(
      acreage: acreage,
      description: description,
      district: district,
      id: id,
      userId: userId,
      images: images,
      location: location,
      name: name,
      price: price,
      status: status,
      userName: userName,
    );
  }

  static Plot fromEntity(PlotEntity entity) {
    return Plot(
      acreage: entity.acreage,
      description: entity.description,
      district: entity.district,
      id: entity.id,
      userId: entity.userId,
      images: entity.images,
      location: entity.location,
      name: entity.name,
      price: entity.price,
      status: entity.status,
      userName: entity.userName,
    );
  }
}
