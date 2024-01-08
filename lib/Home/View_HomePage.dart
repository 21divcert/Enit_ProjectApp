import 'package:flutter/material.dart';
import 'package:stacky_bottom_nav_bar/stacky_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: StackyBottomNavBar(
        params: StackyBottomNavBarParams(
          animatedNavBarItems: [
            StackyAnimatedNavBarItem(
              icon: Icons.videocam, // 예시 아이콘
              onTap: () => print("videocam"),
            ),
            StackyAnimatedNavBarItem(
              icon: Icons.camera, // 예시 아이콘
              onTap: () => print("camera"),
            ),
            StackyAnimatedNavBarItem(
              icon: Icons.picture_in_picture, // 예시 아이콘
              onTap: () => print("picture"),
            ),
          ],
          simpleNavBarItems: [
            StackySimpleNavBarItem(
              icon: Icons.house, // 예시 아이콘
              onTap: () => print("house"),
            ),
            StackySimpleNavBarItem(
              icon: Icons.person, // 예시 아이콘
              onTap: () => print("user"),
            )
          ],
          currentSelectedTabIndex: 0,
        ),
      ),
      body: Row(
        children: <Widget>[
          // 기존의 NavigationRail 코드는 제거하거나 필요에 따라 수정합니다.
          Expanded(
            child: Center(
              child: Text("Selected Page"),
            ),
          )
        ],
      ),
    );
  }
}
