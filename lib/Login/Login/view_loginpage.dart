import 'package:enit_project_app/utils/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../SignUp/view_signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                    children: const [
                      _Logo(),
                      _FormContent(),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Row(
                      children: const [
                        Expanded(child: _Logo()),
                        Expanded(
                          child: Center(child: _FormContent()),
                        ),
                      ],
                    ),
                  )));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

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
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.all(16.0), // 패딩 추가
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEmailField(),
            _gap(),
            _buildPasswordField(),
            _gap(),
            _buildSignUpPrompt(),
            _gap(),
            _buildSignInButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: '이메일',
        hintText: '이메일을 입력해주세요',
        prefixIcon: Icon(Icons.email_outlined),
        border: UnderlineInputBorder(), // 언더라인 스타일
      ),
      // validator 등 나머지 코드...
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: '비밀번호',
        hintText: '비밀번호를 입력해주세요',
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        border: const UnderlineInputBorder(), // 언더라인 스타일
        suffixIcon: IconButton(
          icon: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      // validator 등 나머지 코드...
    );
  }

  Widget _buildSignUpPrompt() {
    return InkWell(
      onTap: () {
        // 회원가입 페이지로 라우팅원
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: const Text(
        '회원가입이 필요하신가요?',
        style: TextStyle(decoration: TextDecoration.underline), // 언더라인 추가
      ),
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.amberAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        '로그인',
        style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: '귀여운폰트'), // 폰트 변경
      ),
      onPressed: () {
        // if (_formKey.currentState?.validate() ?? false) {
        //   // 로그인 처리
        // }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Tabs()));
      },
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
