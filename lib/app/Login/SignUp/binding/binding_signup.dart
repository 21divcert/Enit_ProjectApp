import 'package:get/get.dart';
import '../controller/control_signup.dart';

class JoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignUpController>(SignUpController());
  }
}
