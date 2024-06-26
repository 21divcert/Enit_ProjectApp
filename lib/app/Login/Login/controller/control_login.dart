import 'package:enit_project_app/app/Home/binding/binding_homepage.dart';
import 'package:enit_project_app/app/Root/RootPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../service/auth_service.dart';
import '../../../Home/controller/control_homepage.dart';
import '../../../Model/UserModel/medel_user.dart';
import '../../../utils/tabs.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  final idTextControl = TextEditingController(text: "password@gmail.com");
  final pwTextControl = TextEditingController(text: "password");

  // @override
  // void onInit() {
  //   if (AuthService.to.getCurrentUser() != null) {
  //     Get.to(const MypageView(), binding: MypageBinding());
  //   }
  //   super.onInit();
  // }

  final RxBool isPasswordVisible = true.obs; // 비밀번호 가시성 상태

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value; // 상태 토글
  }

  Future<void> fireAuthLogin() async {
    if (idTextControl.text.isEmpty == true || pwTextControl.text.isEmpty == true) {
      return;
    }

    final loginStatus = await AuthService.to.logInWithEmailAndPassword(email: idTextControl.text, password: pwTextControl.text);
    if (loginStatus == LoginStatus.success) {
      Get.to(() => RootPage(), binding: HomePageBinding());
      return;
    }

    String errString = "새 신을 신 고 뛰어보자 퐐쫙";
    switch (loginStatus) {
      case LoginStatus.invalidEmail:
        errString = "아이디는 이메일 형식이어야 합니다.";
        break;
      case LoginStatus.userDisabled:
        errString = "해당 유저는 차단되었습니다. 관리자에게 문의하세요.";
        break;
      case LoginStatus.userNotFound:
        errString = "비밀번호가 잘못되었거나, 해당 유저가 존재하지 않습니다.";
        break;
      default:
        errString = "예상치 못한 동작입니다. 겪으신 문제점을 관리자에게 문의 드리면 감사하겠습니다.";
    }

    Get.showSnackbar(GetSnackBar(
      title: "로그인에 실패하였습니다.",
      message: errString,
    ));
  }

  @override
  void onClose() {
    idTextControl.dispose();
    pwTextControl.dispose();
    super.onClose();
  }
}
