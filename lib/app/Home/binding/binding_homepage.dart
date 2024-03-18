import 'package:get/get.dart';
import '../controller/control_homepage.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomePageController>(HomePageController());
  }
}
