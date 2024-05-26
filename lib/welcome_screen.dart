import 'package:a_group/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:a_group/auth/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:a_group/auth/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:a_group/auth/views/sign_in_screen.dart';
import 'package:a_group/auth/views/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: TabBar(
                          controller: tabController,
                          indicatorColor: Colors.transparent,
                          unselectedLabelColor: Colors.white.withOpacity(0.3),
                          labelColor: Colors.white,
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                              child: Text(
                                'Вход',
                                style: GoogleFonts.raleway(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                              child: Text(
                                'Регистрация',
                                style: GoogleFonts.raleway(fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            BlocProvider<SignInBloc>(
                              create: (context) => SignInBloc(context.read<AuthenticationBloc>().userRepository),
                              child: const SignInScreen(),
                            ),
                            BlocProvider<SignUpBloc>(
                              create: (context) => SignUpBloc(context.read<AuthenticationBloc>().userRepository),
                              child: const SignUpScreen(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
