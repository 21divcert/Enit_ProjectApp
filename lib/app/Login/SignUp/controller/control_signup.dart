import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:get/get.dart';
import 'package:enit_project_app/package/debug_console.dart';
import 'package:enit_project_app/service/auth_service.dart';
import 'package:enit_project_app/service/server_service.dart';
import 'dart:developer';
import 'dart:convert';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerConfirmPassword =
      TextEditingController();

  final RxString selectedArea = 'STUDENT'.obs; // 기본값으로 'STUDENT' 설정

  // 사용자 입력값을 저장하는 Map
  final Map<String, String> textFieldValues = {
    'email_id': "password@gmail.com",
    'name': "password",
    'role': "STUDENT",
    'pw': "password",
    'pw_repeat': "password",
  };

  final RxBool obscurePassword = true.obs;

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
    obscurePassword.value = !obscurePassword.value;
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

  void updateUserInputValues() {
    textFieldValues['name'] = controllerUsername.text;
    textFieldValues['email_id'] = controllerEmail.text;
    textFieldValues['pw'] = controllerPassword.text;
    textFieldValues['pw_repeat'] = controllerConfirmPassword.text;
    textFieldValues['role'] = selectedArea.value;
  }

  Future<void> userJoin() async {
    updateUserInputValues();

    int emptyCount = 0;
    // 사용자 입력값을 저장하는 Map에서 공백 여부 확인
    textFieldValues.forEach((key, value) {
      if (value.isEmpty) {
        emptyCount++;
      }
    });

    debugConsole(textFieldValues);

    if (emptyCount != 0) {
      return;
    }

    String snackString = "새 신을 신 고 뛰어보자 퐐쫙";
    String title = "회원가입에 실패하였습니다.";

    final status = await AuthService.to.joinWithEmailAndPassword(
        email: textFieldValues['email_id'] ?? "",
        password: textFieldValues['pw'] ?? "",
        passwordRepeat: textFieldValues['pw_repeat'] ?? "");
    switch (status) {
      case JoinStatus.success:
        snackString = "가입을 환영합니다," + controllerUsername.toString() + "님!";
        break;
      case JoinStatus.weakPassword:
        snackString = "비밀번호가 서버에게 패배하였습니다... 더 강력한 비밀번호가 필요합니다!";
        break;
      case JoinStatus.alreadyExistsEmail:
        snackString = "중복되는 이메일입니다.";
        break;
      case JoinStatus.passwordRepeatWrong:
        snackString = "비밀번호 재입력 란이 잘못되었습니다.";
        break;
      default:
        snackString = "예상치 못한 동작입니다. 겪으신 문제점을 관리자에게 문의 드리면 감사하겠습니다.";
    }

    if (status == JoinStatus.success) {
      await ServerAPIService.to.firebaseTokenAdd();
      final Map serverStatus = await ServerAPIService.to.post(
          '/api/users/join',
          ({
            "name": textFieldValues['name'] ?? "",
            "email": textFieldValues['email_id'] ?? "",
            "role": textFieldValues['role'] ?? "",
          }));
      log(serverStatus.toString());
      log(serverStatus["statusCode"].toString());
      // if server response body is not empty, this is the err code. so, delete the token and the account from the firebase Auth.
      if (serverStatus["statusCode"] == 200) {
        title = "환영합니다!";
      } else {
        await AuthService.to.withDrawUser();
        snackString =
            "이름, 이메일, 지위 (name, email, role) 중 하나가 잘못되어, 서버에서 회원등록을 거부하였습니다.";
      }
    }

    final getSnackBar = GetSnackBar(
      title: title,
      message: snackString,
      duration: const Duration(seconds: 2),
    );

    log(snackString);
    log("request : " +
        {
          "name": textFieldValues['name'] ?? "",
          "email": textFieldValues['email_id'] ?? "",
          "role": textFieldValues['role'] ?? "",
        }.toString());

    if (status == JoinStatus.success) {
      Get.back();
      formKey.currentState?.reset();
      Get.toNamed('/login');
      Get.showSnackbar(getSnackBar);
    } else {
      Get.showSnackbar(getSnackBar);
    }
  }
}
