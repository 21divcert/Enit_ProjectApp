import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../service/server_service.dart';

class GrassVOController extends GetxController {
  final ownerFirebaseAuthUID = Rxn<String>();
  final List<int> grasserIntenseList = [];

  void injectOwnerFirebaseAuthUID(String? uid) {
    ownerFirebaseAuthUID.value = uid;
  }

  void initializeOwnerFirebaseAuthUID(String uid) {
    ownerFirebaseAuthUID.value = null;
  }

  Future<void> loadGrassWeekData(Map<String, dynamic> requestData) async {
    final formattedRequestData = {
      "firebaseUID": ownerFirebaseAuthUID.value,
      "year": requestData["year"],
      "targetBoardIdList": requestData["targetBoardIdList"],
    };

    try {
      ServerAPIService serverAPIService = ServerAPIService();
      grasserIntenseList.clear();
      grasserIntenseList.addAll(await serverAPIService.fetchGrassDayData(formattedRequestData) ?? []);
      print("model loadGrassWeekData start!!!!!!!!!!!!!!!!!!");
    } catch (e) {
      print("Error fetching loadGrassWeekData data: $e");
    }
  }

  Future<void> loadGrassDayData(Map<String, dynamic> requestData) async {
    final formattedRequestData = {
      "firebaseUID": ownerFirebaseAuthUID.value,
      "year": requestData["year"],
      "month": requestData["month"],
      "targetBoardIdList": requestData["targetBoardIdList"],
    };

    try {
      ServerAPIService serverAPIService = ServerAPIService();
      grasserIntenseList.clear();
      grasserIntenseList.addAll(await serverAPIService.fetchGrassDayData(formattedRequestData) ?? []);
      print("model loadGrassDayData start!!!!!!!!!!!!!!!!!!");
    } catch (e) {
      print("Error fetching loadGrassDayData data: $e");
    }
  }
}
