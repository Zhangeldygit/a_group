import 'package:a_group/auth/auth_repository/entities/user_entity.dart';

class MyUser {
  String userId;
  String email;
  String name;
  String phone;
  bool hasActiveCart;
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

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $phone, $hasActiveCart, $userType';
  }
}
