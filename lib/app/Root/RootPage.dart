import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../service/server_service.dart';
import '../Home/controller/control_homepage.dart';
import '../utils/tabs.dart';

class RootController extends GetxController {
  final NavigationController navigationController =
      Get.put(NavigationController());
  final HomePageController homePageController = Get.put(HomePageController());
  final ServerAPIService _serverAPIService = Get.put(ServerAPIService());

  @override
  void onInit() {
    super.onInit();
    homePageController.init();
  }
}

class RootPage extends StatelessWidget {
  final RootController rootController = Get.put(RootController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RootController>(
        init: rootController,
        builder: (_) {
          return Tabs();
        },
      ),
    );
  }
}
