import 'package:a_group/components/custom_button.dart';
import 'package:a_group/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  bool isSeller = false;
  final codeController = TextEditingController();
  String? validator;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Укажите вашу роль',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 22),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                title: 'Пользователь',
                onPressed: () {
                  Navigator.pop(context, 'customer');
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                title: 'Менеджер по продажам',
                onPressed: () {
                  isSeller = true;
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          isSeller
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: codeController,
                        hintText: 'Введите код',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (p0) {
                          if (codeController.text == '5555') {
                            Navigator.pop(context, 'seller');
                          } else {
                            validator = 'Неверный код';
                          }
                        },
                      ),
                    ),
                  ],
                )
              : const Offstage(),
          isSeller && (validator?.isNotEmpty ?? false) && validator != '5555'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Text('Неверный код', style: GoogleFonts.poppins(color: Colors.red, fontSize: 14)),
                    ),
                  ],
                )
              : const Offstage()
        ],
      ),
    );
  }
}
