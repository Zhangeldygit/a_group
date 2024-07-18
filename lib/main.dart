import 'package:a_group/app.dart';
import 'package:a_group/auth/auth_repository/entities/user_entity.dart';
import 'package:a_group/auth/auth_repository/firebase_auth_repository.dart';
import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/plots/plots_repository/models/geo_point_adapter.dart';
import 'package:a_group/plots/plots_repository/models/plot_model.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  Hive.registerAdapter(PlotAdapter()); // 0
  Hive.registerAdapter(GeoPointAdapter()); // 1
  Hive.registerAdapter(MyUserEntityAdapter()); // 2
  Hive.registerAdapter(MyUserAdapter()); // 3
  await Hive.openBox('plots');
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MainApp(
        userRepository: FirebaseUserRepo(),
      ),
    ),
  );
}
