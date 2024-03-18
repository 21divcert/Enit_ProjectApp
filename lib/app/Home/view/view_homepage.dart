import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/UserModel/medel_user.dart';
import '../../utils/appbar.dart';
import '../controller/control_homepage.dart';
import 'view_profilebottomsheet.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: GetBuilder<HomePageController>(
        init: HomePageController(), // 초기화 시점 변경
        builder: (controller) {
          Users me = controller.me;
          Map<String, List<Users>> groupedUsers = controller.groupedUsers;

          return Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              image: DecorationImage(
                image: AssetImage('assets/images/home_background.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.08),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: ListView(
              children: [
                UserListView(
                  user: me,
                  me: me,
                ),
                ...groupedUsers.entries
                    .map(
                      (entry) => _buildUserTypePanel(
                        context,
                        entry.key,
                        entry.value,
                      ),
                    )
                    .toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserTypePanel(
    BuildContext context,
    String role,
    List<Users> userList,
  ) {
    // 빈칸일 때의 처리 추가
    if (role.isEmpty || userList.isEmpty) {
      return SizedBox.shrink();
    }

    return ExpansionTile(
      initiallyExpanded: userList[0].isPanelOpen,
      title: Text(role),
      onExpansionChanged: (isOpen) {
        userList[0].isPanelOpen = isOpen;
      },
      children: userList
          .map((user) => UserListView(
                user: user,
                me: controller.me,
              ))
          .toList(),
    );
  }
}

class UserListView extends StatelessWidget {
  final Users me;
  final Users user;

  UserListView({required this.me, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/happy.png'),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.content_paste),
            onPressed: () {
              // 클릭 이벤트
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // 클릭 이벤트
            },
          ),
        ],
      ),
      onTap: () {
        user.isPanelOpen = !user.isPanelOpen;
        ProfileBottomSheet.showProfileBottomSheet(context, me);
      },
    );
  }
}
