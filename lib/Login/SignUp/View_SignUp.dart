import 'package:flutter/material.dart';
import 'control_signup.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpController _controller;
  String? _selectedArea;

  @override
  void initState() {
    super.initState();
    _controller = SignUpController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Form(
        key: _controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset(
                'assets/images/happy.png',
                width: 200,
                height: 200,
              ),
              Text(
                "어서오세요",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "계정을 생성해주세요!",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Text(
                "어떤 유형에 속하시나요?",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton("아이", "child"),
                  const SizedBox(width: 20),
                  _buildToggleButton("부모", "parent"),
                  const SizedBox(width: 20),
                  _buildToggleButton("교육 관계자", "educator"),
                ],
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: _controller.controllerUsername,
                labelText: "이름",
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "이름이 비었어요!";
                  }
                  // Add more validation logic if needed
                  return null;
                },
                onEditingComplete: () =>
                    _controller.focusNodeEmail.requestFocus(),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _controller.controllerEmail,
                focusNode: _controller.focusNodeEmail,
                labelText: "이메일",
                icon: Icons.email_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "이메일이 비었어요!";
                  } else if (!(value.contains('@') && value.contains('.'))) {
                    return "이메일 형식이 잘못되었어요!";
                  }
                  return null;
                },
                onEditingComplete: () =>
                    _controller.focusNodePassword.requestFocus(),
              ),
              const SizedBox(height: 10),
              _buildPasswordField(
                controller: _controller.controllerPassword,
                focusNode: _controller.focusNodePassword,
                labelText: "비밀번호",
                onEditingComplete: () =>
                    _controller.focusNodeConfirmPassword.requestFocus(),
              ),
              const SizedBox(height: 10),
              _buildPasswordField(
                controller: _controller.controllerConfirmPassword,
                focusNode: _controller.focusNodeConfirmPassword,
                labelText: "비밀번호 확인",
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "비밀번호를 입력해주세요.";
                  } else if (value != _controller.controllerPassword.text) {
                    return "비밀번호가 일치하지 않습니다.";
                  } else if (!SignUpController().isPasswordValid(value)) {
                    return "비밀번호 형식이 맞지 않아요!";
                  }
                  return null;
                },
                onEditingComplete: () {
                  // 다음 필드로 포커스 이동 또는 폼 제출 등의 로직
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (_controller.validateForm()) {
                    _controller.registerUser(context);
                  }
                },
                child: const Text(
                  "등록하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ), // 텍스트 색상을 흰색으로 설정
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("혹시 계정이 있었나요?"),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("로그인 페이지"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    FocusNode? focusNode,
    required String labelText,
    required IconData icon,
    required String? Function(String?) validator,
    VoidCallback? onEditingComplete,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      onEditingComplete: onEditingComplete,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    FocusNode? focusNode,
    required String labelText,
    String? Function(String?)? validator,
    VoidCallback? onEditingComplete,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: _controller.obscurePassword,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: const Icon(Icons.password_outlined),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _controller.togglePasswordVisibility();
            });
          },
          icon: Icon(
            _controller.obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
      onEditingComplete: onEditingComplete,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildToggleButton(String text, String area) {
    final bool isSelected = _selectedArea == area;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedArea = area;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.deepOrangeAccent : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.deepOrangeAccent : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
