import 'package:a_group/app.dart';
import 'package:a_group/auth/auth_repository/firebase_auth_repository.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Bloc.observer = SimpleBlocObserver();
  runApp(
    DevicePreview(
      builder: (context) => MainApp(
        userRepository: FirebaseUserRepo(),
      ),
    ),
  );
}
