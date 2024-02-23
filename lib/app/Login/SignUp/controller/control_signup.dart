// Controller_SignUp.dart
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:get/get.dart';
import 'package:enit_project_app/package/debug_console.dart';
import 'package:enit_project_app/service/auth_service.dart';
import 'package:enit_project_app/service/server_service.dart';
import 'dart:developer';
import 'dart:convert';

class SignUpController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerConfirmPassword =
      TextEditingController();

  bool obscurePassword = true;

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  bool isPasswordValid(String password) {
    // 비밀번호가 8자 이상, 20자 이하이며, 소문자, 숫자, 특수문자를 포함하는지 확인
    String pattern = r'^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,20}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  void registerUser(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 200,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        content: const Text("등록이 완료되었어요!"),
      ),
    );

    formKey.currentState?.reset();
  }

  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    controllerUsername.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerConfirmPassword.dispose();
  }
}
