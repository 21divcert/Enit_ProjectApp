import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/control_boardpage.dart';

class BoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardController>(() => BoardController());
  }
}
