import 'package:a_group/auth/auth_repository/models/user_model.dart';

abstract class AuthRepository {
  Stream<MyUser?> get user;

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> setUserData(MyUser user, String userTypee);

  Future<void> signIn(String email, String password);

  Future<void> logOut();

  Future<void> deleteUser(MyUser myUser);
}
