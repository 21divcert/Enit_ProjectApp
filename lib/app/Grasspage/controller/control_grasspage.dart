import 'package:get/get.dart';
import '../../Model/UserModel/medel_user.dart';

class GrassPageController extends GetxController {
  late Users me = Users(name: 'aa', email: 'aa', role: 'aa');
  late List<Users> userList = [];

  // init 메서드 추가
  void init() {
    GrassloadUserData();
    update(); // GetX update 호출하여 UI 갱신
  }

  Future<void> GrassloadUserData() async {
    print("Grass loadUserData start");

    UserVOController userVOController = Get.put(UserVOController());
    await userVOController.loadUserData();

    me = userVOController.userVO.value?.me ?? Users(name: '', email: '', role: '');
    // userList = userVOController.userVO.value?.userList ?? [];
  }
}
