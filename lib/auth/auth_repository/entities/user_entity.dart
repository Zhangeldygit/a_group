import 'package:hive_flutter/hive_flutter.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 2)
class MyUserEntity {
  @HiveField(0)
  String userId;

  @HiveField(1)
  String email;

  @HiveField(2)
  String name;

  @HiveField(3)
  String phone;

  @HiveField(4)
  bool hasActiveCart;

  @HiveField(5)
  String userType;

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.hasActiveCart,
    required this.userType,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'phone': phone,
      'hasActiveCart': hasActiveCart,
      'user_type': userType,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
        userId: doc['userId'] ?? '',
        email: doc['email'] ?? '',
        name: doc['name'] ?? '',
        phone: doc['phone'] ?? '',
        hasActiveCart: doc['hasActiveCart'] ?? false,
        userType: doc['user_type'] ?? '');
  }
}
