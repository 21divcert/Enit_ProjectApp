import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/tabs.dart';

class RootPage extends StatelessWidget {
  final NavigationController navigationController =
      Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tabs(),
    );
  }
}
