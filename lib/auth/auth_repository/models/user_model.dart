import 'package:a_group/auth/auth_repository/entities/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 3)
class MyUser {
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

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.hasActiveCart,
    required this.userType,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
    name: '',
    phone: '',
    hasActiveCart: false,
    userType: '',
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      phone: phone,
      hasActiveCart: hasActiveCart,
      userType: userType,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        userId: entity.userId, email: entity.email, name: entity.name, phone: entity.phone, hasActiveCart: entity.hasActiveCart, userType: entity.userType);
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
      phone: doc['phone'],
      hasActiveCart: doc['hasActiveCart'],
      userType: doc['user_type'],
    );
  }

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

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $phone, $hasActiveCart, $userType';
  }
}
