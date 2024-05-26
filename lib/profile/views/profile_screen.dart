import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:a_group/auth/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:a_group/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  MyUser? myUser;
  @override
  void initState() {
    context.read<AuthenticationBloc>().userRepository.user.first.then((value) {
      setState(() {
        myUser = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final phone =
        MaskTextInputFormatter(mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy, initialText: myUser?.phone);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: 120.0,
                          height: 120.0,
                          padding: const EdgeInsets.all(8),
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(80.0), color: Colors.white, border: Border.all(color: Colors.greenAccent)),
                          child: SvgPicture.asset('lib/assets/icons/profile_info.svg'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const Divider(
                thickness: 0.5,
              ),
              TextField(
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF5C5C5C)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: myUser?.name ?? 'Name',
                  hintStyle: GoogleFonts.poppins(color: const Color(0xFFCFD7F6)),
                  enabled: false,
                  prefixIcon: const Icon(Icons.person_pin, color: Color(0xFFCFD7F6)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF5C5C5C)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'г. Алматы',
                  hintStyle: GoogleFonts.poppins(color: const Color(0xFFCFD7F6)),
                  enabled: false,
                  prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFFCFD7F6)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF5C5C5C)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: phone.getMaskedText(),
                  hintStyle: GoogleFonts.poppins(color: const Color(0xFFCFD7F6)),
                  enabled: false,
                  prefixIcon: const Icon(Icons.call, color: Color(0xFFCFD7F6)),
                ),
              ),
              const Spacer(),
              CustomButton(
                title: 'Выйти',
                onPressed: () {
                  context.read<SignInBloc>().add(SignOutRequired());
                },
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
