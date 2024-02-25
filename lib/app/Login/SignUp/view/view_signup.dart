import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/control_signup.dart';

class newSignUpPage extends StatelessWidget {
  final SignUpController _controller = Get.put(SignUpController());

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
                  _buildToggleButton(context, "아이", "STUDENT"),
                  const SizedBox(width: 20),
                  _buildToggleButton(context, "부모", "PARENT"),
                  const SizedBox(width: 20),
                  _buildToggleButton(context, "교육 관계자", "TEACHER"),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "비밀번호를 입력해주세요.";
                  } else if (value != _controller.controllerPassword.text) {
                    return "비밀번호가 일치하지 않습니다.";
                  } else if (!_controller.isPasswordValid(value)) {
                    return "비밀번호 형식이 맞지 않아요!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (_controller.validateForm()) {
                    _controller.userJoin();
                  }
                },
                child: const Text(
                  "등록하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
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

  Widget _buildToggleButton(BuildContext context, String text, String area) {
    return Obx(() {
      final bool isSelected = _controller.selectedArea.value == area;
      return InkWell(
        onTap: () {
          _controller.selectedArea.value = area;
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
    });
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
    return Obx(() => TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: _controller.obscurePassword.value,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: const Icon(Icons.password_outlined),
            suffixIcon: IconButton(
              icon: Icon(
                _controller.obscurePassword.value
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                _controller.obscurePassword.toggle();
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: validator,
          onEditingComplete: onEditingComplete,
        ));
  }
}
