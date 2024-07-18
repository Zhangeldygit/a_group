import 'package:a_group/auth/auth_repository/entities/user_entity.dart';
import 'package:a_group/plots/plots_repository/entities/plot_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'plot_model.g.dart';

@HiveType(typeId: 0)
class Plot {
  @HiveField(0)
  num? acreage;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? district;
  @HiveField(3)
  String? id;
  @HiveField(4)
  List<dynamic>? images;
  @HiveField(5)
  GeoPoint? location;
  @HiveField(6)
  String? name;
  @HiveField(7)
  int? price;
  @HiveField(8)
  String? status;
  @HiveField(9)
  MyUserEntity? myUser;
  @HiveField(10)
  String? appointment;
  @HiveField(11)
  String? divisibility;
  @HiveField(12)
  bool isFavorite;

  Plot({
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
    this.isFavorite = false,
  });

  PlotEntity toEntity() {
    return PlotEntity(
      acreage: acreage,
      description: description,
      district: district,
      id: id,
      images: images,
      location: location,
      name: name,
      price: price,
      status: status,
      myUser: myUser,
      appointment: appointment,
      divisibility: divisibility,
    );
  }

  static Plot fromEntity(PlotEntity entity) {
    return Plot(
      acreage: entity.acreage,
      description: entity.description,
      district: entity.district,
      id: entity.id,
      images: entity.images,
      location: entity.location,
      name: entity.name,
      price: entity.price,
      status: entity.status,
      myUser: entity.myUser,
      appointment: entity.appointment,
      divisibility: entity.divisibility,
    );
  }
}
