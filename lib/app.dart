import 'package:a_group/app_view.dart';
import 'package:a_group/auth/auth_repository/auth_repository.dart';
import 'package:a_group/auth/bloc/auth_bloc/auth_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  final AuthRepository userRepository;
  const MainApp({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: const MyAppView(),
    );
  }
}
