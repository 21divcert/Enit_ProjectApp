import 'package:enit_project_app/app/Model/BoardModel/model_board.dart';
import 'package:enit_project_app/app/Model/GrassModel/model_grass.dart';
import 'package:enit_project_app/service/auth_service.dart';
import 'package:get/get.dart';
import '../../Model/UserModel/medel_user.dart';

class GrassPageController extends GetxController {
  final List<int> grassWeekList = [];
  final List<int> grassDayList = [];
  final targetDateTime = DateTime.now();
  final isWeekGrasser = false;

  final List<String> targetBoardIdList = [];

  // init 메서드 추가
  @override
  void onInit() {
    final boardVOController = Get.put(BoardVOController());
    final grassVOController = Get.put(GrassVOController());

    if (boardVOController.ownerFirebaseAuthUID.value != null) {
      grassVOController.injectOwnerFirebaseAuthUID(boardVOController.ownerFirebaseAuthUID.value);
    } else {
      grassVOController.injectOwnerFirebaseAuthUID(AuthService.to.getCurrentUser()?.uid);
      boardVOController.injectOwnerFirebaseAuthUID(AuthService.to.getCurrentUser()?.uid);
    }
    super.onInit();
    GrassloadData();
  }

  Future<void> GrassloadData() async {
    print("Grass loadUserData start");

    // get the all of the board id.
    

    GrassVOController grassVOController = Get.put(GrassVOController());
    final ownerUID = grassVOController.ownerFirebaseAuthUID.value;
    await grassVOController.loadGrassWeekData();

    me = grassVOController.userVO.value?.me ?? Users(name: '', email: '', role: '');
    // userList = userVOController.userVO.value?.userList ?? [];
  }
}
