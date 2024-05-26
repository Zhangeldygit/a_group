import 'package:a_group/auth/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:a_group/components/colors.dart';
import 'package:a_group/components/custom_button.dart';
import 'package:a_group/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = Icons.remove_red_eye_outlined;
  bool obscurePassword = true;
  String? _errorMsg;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          setState(() {
            signInRequired = false;
          });
        } else if (state is SignInProcess) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
            if (state.error.isNotEmpty) {
              _errorMsg = 'Данный адрес электронной почты не существует';
            } else {
              _errorMsg = 'Неправильный адрес электронной почты или пароль';
            }
          });
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(
                      Icons.mail_outline,
                      color: AppColors.iconColor,
                    ),
                    errorMsg: _errorMsg,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Пожалуйста, заполните это поле';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                        return 'Введите действительный адрес электронной почты';
                      }
                      return null;
                    })),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: passwordController,
                hintText: 'Пароль',
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.iconColor),
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Пожалуйста, заполните это поле';
                  } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                    return 'введите действительный пароль';
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
                  icon: Icon(
                    iconPassword,
                    color: AppColors.iconColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            !signInRequired
                ? CustomButton(
                    title: 'Войти',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignInBloc>().add(SignInRequired(emailController.text, passwordController.text));
                      }
                    },
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
