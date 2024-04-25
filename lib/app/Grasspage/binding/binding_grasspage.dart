import 'package:enit_project_app/app/Grasspage/controller/control_grasspage.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GrassPageController>(GrassPageController());
  }
}
