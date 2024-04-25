import 'dart:developer';

import 'package:enit_project_app/app/Model/BoardModel/model_board.dart';
import 'package:enit_project_app/app/Model/GrassModel/model_grass.dart';
import 'package:enit_project_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../Model/UserModel/medel_user.dart';

class GrassPageController extends GetxController {
  final boardVOController = Get.put(BoardVOController());
  final grassVOController = Get.put(GrassVOController());

  final List<List<int>> grasserIntenseList = [];

  final int indexMonthRange = 3;
  final int indexYearRange = 1;
  var targetDateTime = DateTime.now().obs;
  final isWeekGrasser = false.obs;

  final List<int> targetBoardIdList = [];

  RxBool isRefreshGrasserComplete = false.obs;

  // init 메서드 추가
  @override
  void onInit() {
    if (boardVOController.ownerFirebaseAuthUID.value != null) {
      grassVOController.injectOwnerFirebaseAuthUID(boardVOController.ownerFirebaseAuthUID.value);
    } else {
      grassVOController.injectOwnerFirebaseAuthUID(AuthService.to.getCurrentUser()?.uid);
      boardVOController.injectOwnerFirebaseAuthUID(AuthService.to.getCurrentUser()?.uid);
    }
    _grassLoadData();
    grassRefreshData();
    super.onInit();
  }

  void clearData() {
    grasserIntenseList.clear();
  }

  void grassRefreshData() {
    isRefreshGrasserComplete.value = false;
    _grassRefreshData().whenComplete(() {
      isRefreshGrasserComplete.value = true;
    });
  }

  Future<int> _grassLoadData() async {
    try {
      grasserIntenseList.clear();
      print("Grass loadUserData start");

      // get the all of the board id.
      targetBoardIdList.clear();
      targetBoardIdList.addAll(await boardVOController.loadBoardIdList());

      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<int> _grassRefreshData() async {
    try {
      grasserIntenseList.clear();
      if (isWeekGrasser == false) {
        // day-based grasser
        // add +- indexRange-month from current selected month
        for (int i = -indexMonthRange; i <= indexMonthRange; i++) {
          final dayBasedGrasser = await grassVOController.loadGrassDayData({
            "year": targetDateTime.value.year,
            "month": targetDateTime.value.month + i,
            "targetBoardIdList": targetBoardIdList,
          });

          final List<int> newSection = [];
          for (dynamic value in dayBasedGrasser ?? []) {
            if (value.runtimeType == String) {
              newSection.add(int.parse(value));
            } else if (value.runtimeType == int) {
              newSection.add(value);
            } else {
              throw Exception();
            }
          }
          grasserIntenseList.add(newSection);
        }
      } else {
        // week-based grasser
        // add +- indexRange-year from current selected month
        for (int i = -indexYearRange; i <= indexYearRange; i++) {
          final dayBasedGrasser = await grassVOController.loadGrassWeekData({
            "year": targetDateTime.value.year + i,
            "targetBoardIdList": targetBoardIdList,
          });

          final List<int> newSection = [];
          for (dynamic value in dayBasedGrasser ?? []) {
            if (value.runtimeType == String) {
              newSection.add(int.parse(value));
            } else if (value.runtimeType == int) {
              newSection.add(value);
            } else {
              throw Exception();
            }
          }
          grasserIntenseList.add(newSection);
        }
      }
      return 1;
    } catch (e) {
      return 0;
    }
  }
}
