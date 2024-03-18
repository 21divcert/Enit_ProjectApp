import 'package:get/get.dart';
import '../../Model/UserModel/medel_user.dart';

class HomePageController extends GetxController {
  late Users me = Users(name: 'aa', email: 'aa', role: 'aa');
  late List<Users> userList = [];
  late Map<String, List<Users>> groupedUsers = {};

  // init 메서드 추가
  void init() {
    HomeloadUserData();
    update(); // GetX update 호출하여 UI 갱신
  }

  Future<void> HomeloadUserData() async {
    print("Home loadUserData start");

    UserVOController userVOController = Get.put(UserVOController());
    await userVOController.loadUserData();

    me = userVOController.userVO.value?.me ??
        Users(name: '', email: '', role: '');
    userList = userVOController.userVO.value?.userList ?? [];
    groupedUsers = _groupUsersByRole(userList);
  }

  Map<String, List<Users>> _groupUsersByRole(List<Users> users) {
    Map<String, List<Users>> groupedUsers = {};
    for (var user in users) {
      if (!groupedUsers.containsKey(user.role)) {
        groupedUsers[user.role] = [];
      }
      groupedUsers[user.role]!.add(user);
    }
    return groupedUsers;
  }
}
