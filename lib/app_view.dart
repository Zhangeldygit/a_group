import 'package:a_group/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:a_group/auth/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:a_group/main_screen.dart';
import 'package:a_group/plots/bloc/plots_bloc.dart';
import 'package:a_group/plots/plots_repository/firebase_plots_repository.dart';
import 'package:a_group/status/bloc/status_bloc.dart';
import 'package:a_group/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'aGroup APP',
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SignInBloc(context.read<AuthenticationBloc>().userRepository),
                  ),
                  BlocProvider(
                    create: (context) => GetPlotsBloc(FirebasePlotsRepo())..add(GetPlots(userType: state.user?.userType, userId: state.user?.userId)),
                  ),
                  BlocProvider<StatusCubit>(
                    create: (context) => StatusCubit(FirebasePlotsRepo())..filterByCategory(userType: state.user?.userType, userId: state.user?.userId),
                  )
                ],
                child: MainScreen(user: state.user),
              );
            } else {
              return const WelcomeScreen();
            }
          }),
        ));
  }
}
