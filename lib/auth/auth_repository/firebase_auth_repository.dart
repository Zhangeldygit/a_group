import 'dart:developer';

import 'package:a_group/auth/auth_repository/auth_repository.dart';
import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:a_group/auth/auth_repository/entities/user_entity.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseUserRepo implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final sellersCollection = FirebaseFirestore.instance.collection('sellers');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield MyUser.empty;
      } else {
        yield await usersCollection.doc(firebaseUser.uid).get().then((value) async {
          if (value.data() != null) {
            return MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!));
          } else {
            return await sellersCollection.doc(firebaseUser.uid).get().then((value) => MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
          }
        });
      }
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log("zahnnnn sign in ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: myUser.email, password: password);

      myUser.userId = user.user!.uid;
      return myUser;
    } catch (e) {
      log("zahnnnn sign up ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser, String userType) async {
    try {
      if (userType == 'seller') {
        await sellersCollection.doc(myUser.userId).set(myUser.toEntity().toDocument());
      } else {
        await usersCollection.doc(myUser.userId).set(myUser.toEntity().toDocument());
      }
    } catch (e) {
      log("zahnnnn set user Data ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(MyUser myUser) async {
    if (myUser.userType == 'seller') {
      await sellersCollection.doc(myUser.userId).delete();
      await _firebaseAuth.currentUser?.delete();
    } else {
      await usersCollection.doc(myUser.userId).delete();
      await _firebaseAuth.currentUser?.delete();
    }
  }
}
