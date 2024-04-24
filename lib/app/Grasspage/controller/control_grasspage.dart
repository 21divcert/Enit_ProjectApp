import 'package:enit_project_app/app/Model/BoardModel/model_board.dart';
import 'package:enit_project_app/app/Model/GrassModel/model_grass.dart';
import 'package:enit_project_app/service/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../Model/UserModel/medel_user.dart';

class GrassPageController extends GetxController {
  final boardVOController = Get.put(BoardVOController());
  final grassVOController = Get.put(GrassVOController());

  final List<List<int>> grasserIntenseList = [];
  final int indexRange = 3;
  var targetDateTime = DateTime.now().obs;
  final isWeekGrasser = false.obs;

  final List<int> targetBoardIdList = [];

  // init 메서드 추가
  @override
  void onInit() {
    if (boardVOController.ownerFirebaseAuthUID.value != null) {
      grassVOController.injectOwnerFirebaseAuthUID(boardVOController.ownerFirebaseAuthUID.value);
    } else {
      grassVOController.injectOwnerFirebaseAuthUID(AuthService.to.getCurrentUser()?.uid);
      boardVOController.injectOwnerFirebaseAuthUID(AuthService.to.getCurrentUser()?.uid);
    }
    super.onInit();
    grasserIntenseList.clear();
    grassloadData();
  }

  void clearData() {
    grasserIntenseList.clear();
  }

  Future<void> grassloadData() async {
    print("Grass loadUserData start");

    // get the all of the board id.
    targetBoardIdList.clear();
    targetBoardIdList.addAll(await boardVOController.loadBoardIdList());

    GrassVOController grassVOController = Get.put(GrassVOController());
    final ownerUID = grassVOController.ownerFirebaseAuthUID.value;

    await grassRefreshData();
  }

  Future<void> grassRefreshData() async {
    grasserIntenseList.clear();
    if (isWeekGrasser == false) {
      // day-based grasser
      // add +- indexRange-month from current selected month
      for (int i = -indexRange; i <= indexRange; i++) {
        final dayBasedGrasser = await grassVOController.loadGrassDayData({
          "year": targetDateTime.value.year,
          "month": targetDateTime.value.month + i,
          "targetBoardIdList": targetBoardIdList,
        });
        
        final List<int> newSection = [];
        grasserIntenseList.add(newSection);
        for (dynamic value in dayBasedGrasser ?? []) {
          if (value.runtimeType == String) {
            newSection.add(int.parse(value));
          } else if (value.runtimeType == int) {
            newSection.add(value);
          } else {
            throw Exception();
          }
        }
      }
    } else {
      // week-based grasser
      // add +- indexRange-year from current selected month
      for (int i = -indexRange; i <= indexRange; i++) {
        final dayBasedGrasser = await grassVOController.loadGrassDayData({
          "year": targetDateTime.value.year + i,
          "targetBoardIdList": targetBoardIdList,
        });

        final List<int> newSection = [];
        grasserIntenseList.add(newSection);
        for (dynamic value in dayBasedGrasser ?? []) {
          if (value.runtimeType == String) {
            newSection.add(int.parse(value));
          } else if (value.runtimeType == int) {
            newSection.add(value);
          } else {
            throw Exception();
          }
        }
      }
    }
  }
}
