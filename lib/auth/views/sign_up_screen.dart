import 'package:a_group/auth/auth_repository/models/user_model.dart';
import 'package:a_group/auth/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:a_group/choose_roles_screen.dart';
import 'package:a_group/components/colors.dart';
import 'package:a_group/components/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../components/my_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = Icons.remove_red_eye_outlined;
  bool obscurePassword = true;
  bool signUpRequired = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  var maskFormatter = MaskTextInputFormatter(mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          return;
        }
      },
      child: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.mail_outline, color: AppColors.iconColor),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Пожалуйста, заполните это поле';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                          return 'Введите действительный адрес электронной почты';
                        }
                        return null;
                      }),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                      controller: passwordController,
                      hintText: 'Пароль',
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.iconColor),
                      onChanged: (val) {
                        if (val!.contains(RegExp(r'[A-Z]'))) {
                          setState(() {
                            containsUpperCase = true;
                          });
                        } else {
                          setState(() {
                            containsUpperCase = false;
                          });
                        }
                        if (val.contains(RegExp(r'[a-z]'))) {
                          setState(() {
                            containsLowerCase = true;
                          });
                        } else {
                          setState(() {
                            containsLowerCase = false;
                          });
                        }
                        if (val.contains(RegExp(r'[0-9]'))) {
                          setState(() {
                            containsNumber = true;
                          });
                        } else {
                          setState(() {
                            containsNumber = false;
                          });
                        }
                        if (val.contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                          setState(() {
                            containsSpecialChar = true;
                          });
                        } else {
                          setState(() {
                            containsSpecialChar = false;
                          });
                        }
                        if (val.length >= 8) {
                          setState(() {
                            contains8Length = true;
                          });
                        } else {
                          setState(() {
                            contains8Length = false;
                          });
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                            if (obscurePassword) {
                              iconPassword = Icons.remove_red_eye;
                            } else {
                              iconPassword = Icons.remove_red_eye_outlined;
                            }
                          });
                        },
                        icon: Icon(iconPassword, color: AppColors.iconColor),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Пожалуйста, заполните это поле';
                        } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                          return 'введите действительный пароль';
                        }
                        return null;
                      }),
                ),
                const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "⚈  1 верхний регистр",
                //           style: TextStyle(color: containsUpperCase ? Colors.green : Theme.of(context).colorScheme.onBackground),
                //         ),
                //         Text(
                //           "⚈  1 нижний регистр",
                //           style: TextStyle(color: containsLowerCase ? Colors.green : Theme.of(context).colorScheme.onBackground),
                //         ),
                //         Text(
                //           "⚈  1 number",
                //           style: TextStyle(color: containsNumber ? Colors.green : Theme.of(context).colorScheme.onBackground),
                //         ),
                //       ],
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "⚈  1 special character",
                //           style: TextStyle(color: containsSpecialChar ? Colors.green : Theme.of(context).colorScheme.onBackground),
                //         ),
                //         Text(
                //           "⚈  8 minimum character",
                //           style: TextStyle(color: contains8Length ? Colors.green : Theme.of(context).colorScheme.onBackground),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                      controller: phoneController,
                      hintText: 'Номер телефона',
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [maskFormatter],
                      prefixIcon: const Icon(Icons.phone_sharp, color: AppColors.iconColor),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Пожалуйста, заполните это поле';
                        } else if (val.length > 20) {
                          return 'Номер слишком длинный';
                        }
                        return null;
                      }),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextField(
                      controller: nameController,
                      hintText: 'Имя',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.person_2_outlined, color: AppColors.iconColor),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Пожалуйста, заполните это поле';
                        } else if (val.length > 30) {
                          return 'Имя слишком длинное';
                        }
                        return null;
                      }),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                !signUpRequired
                    ? CustomButton(
                        title: 'Регистрация',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final result = showModalBottomSheet(context: context, builder: (context) => const ChooseRoleScreen());
                            result.then((value) {
                              if (value != null) {
                                MyUser myUser = MyUser.empty;
                                myUser.email = emailController.text;
                                myUser.name = nameController.text;
                                myUser.phone = maskFormatter.getUnmaskedText();
                                myUser.userType = value;
                                context.read<SignUpBloc>().add(SignUpRequired(myUser, passwordController.text, value));
                              }
                            });
                          }
                        },
                      )
                    : const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
