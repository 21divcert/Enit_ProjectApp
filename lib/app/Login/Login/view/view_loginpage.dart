import 'package:enit_project_app/app/Login/Login/controller/control_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../../utils/tabs.dart';
import '../../SignUp/view/view_signup.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    FlutterNativeSplash.remove();
    return Scaffold(
        backgroundColor: Colors.pink.shade50,
        body: Center(
            child: isSmallScreen
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Logo(),
                      FormContent(controller: controller),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Row(
                      children: [
                        Expanded(child: Logo()),
                        Expanded(
                          child: Center(
                              child: FormContent(controller: controller)),
                        ),
                      ],
                    ),
                  )));
  }

  Widget Logo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/logo.png'),
        Padding(
          padding: const EdgeInsets.all(16.0),
        )
      ],
    );
  }

  Widget FormContent({required LoginController controller}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEmailField(controller),
            _gap(),
            _buildPasswordField(controller),
            _gap(),
            _buildSignUpPrompt(),
            _gap(),
            _buildSignInButton(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField(LoginController controller) {
    return TextFormField(
      controller: controller
          .idTextControl, // GetX Controller에서 관리하는 TextEditingController 사용
      decoration: const InputDecoration(
        labelText: '이메일',
        hintText: '이메일을 입력해주세요',
        prefixIcon: Icon(Icons.email_outlined),
        border: UnderlineInputBorder(),
      ),
      validator: (value) {
        // 이메일 유효성 검사 로직
      },
    );
  }

  Widget _buildPasswordField(LoginController controller) {
    return Obx(() => TextFormField(
          controller: controller.pwTextControl,
          obscureText: controller.isPasswordVisible.value,
          decoration: InputDecoration(
            labelText: '비밀번호',
            hintText: '비밀번호를 입력해주세요',
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            border: const UnderlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                controller.togglePasswordVisibility();
              },
            ),
          ),
        ));
  }

  Widget _buildSignUpPrompt() {
    return InkWell(
      onTap: () => Get.to(() => SignUpPage()), // GetX 라우팅 사용
      child: const Text(
        '회원가입이 필요하신가요?',
        style: TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }

  Widget _buildSignInButton(LoginController controller) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amberAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        '로그인',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () => controller.fireAuthLogin(),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
