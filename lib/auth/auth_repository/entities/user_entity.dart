class MyUserEntity {
  String userId;
  String email;
  String name;
  String phone;
  bool hasActiveCart;
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
