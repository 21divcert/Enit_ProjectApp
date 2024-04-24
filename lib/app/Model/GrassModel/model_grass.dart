import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../service/server_service.dart';

class GrassVOController extends GetxController {
  final ownerFirebaseAuthUID = Rxn<String>();

  void injectOwnerFirebaseAuthUID(String? uid) {
    ownerFirebaseAuthUID.value = uid;
  }

  void initializeOwnerFirebaseAuthUID(String uid) {
    ownerFirebaseAuthUID.value = null;
  }

  Future<List<dynamic>?> loadGrassWeekData(Map<String, dynamic> requestData) async {
    final formattedRequestData = {
      "firebaseUID": ownerFirebaseAuthUID.value,
      "year": requestData["year"],
      "targetBoardIdList": requestData["targetBoardIdList"],
    };

    try {
      ServerAPIService serverAPIService = ServerAPIService();
      print("model loadGrassWeekData start!!!!!!!!!!!!!!!!!!");
      return await serverAPIService.fetchGrassWeekData(formattedRequestData);
    } catch (e) {
      print("Error fetching loadGrassWeekData data: $e");
    }
  }

  Future<List<dynamic>?> loadGrassDayData(Map<String, dynamic> requestData) async {
    final formattedRequestData = {
      "firebaseUID": ownerFirebaseAuthUID.value,
      "year": requestData["year"],
      "month": requestData["month"],
      "targetBoardIdList": requestData["targetBoardIdList"],
    };

    try {
      ServerAPIService serverAPIService = ServerAPIService();
      print("model loadGrassDayData start!!!!!!!!!!!!!!!!!!");
      return await serverAPIService.fetchGrassDayData(formattedRequestData);
    } catch (e) {
      print("Error fetching loadGrassDayData data: $e");
    }
  }
}
