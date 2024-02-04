import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import '../Home/view_homepage.dart';
import '../Board/view_boardpage.dart';
import '../Grasspage/view_grasspage.dart';

class Tabs extends StatelessWidget {
  final NavigationController navigationController = Get.find();

  Tabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (navigationController.tabIndex.value) {
          case 0:
            return HomePage(); // 홈 페이지 위젯
          case 1:
            return BoardPage(); // 보드 페이지 위젯
          case 2:
            return GrassPage(); // 마이 페이지 위젯
          default:
            return HomePage(); // 기본값으로 홈 페이지 반환
        }
      }),
      bottomNavigationBar: Obx(() => Container(
            color: Colors.blue.shade50,
            child: MoltenBottomNavigationBar(
              selectedIndex: navigationController.tabIndex.value,
              domeCircleColor: Color(0xfffc4ebb2),
              domeCircleSize: 70,
              onTabChange: (index) {
                navigationController.changeTab(index);
              },
              tabs: [
                MoltenTab(icon: Image.asset('assets/images/Home_Icon.png')),
                MoltenTab(icon: Image.asset('assets/images/Board.png')),
                MoltenTab(icon: Image.asset('assets/images/Grass.png')),
              ],
            ),
          )),
    );
  }
}

class NavigationController extends GetxController {
  var tabIndex = 0.obs;

  void changeTab(int index) {
    tabIndex.value = index;
  }
}
