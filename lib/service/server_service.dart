import 'dart:convert';
import 'package:enit_project_app/app/Board/controller/control_boardpage.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:http/http.dart" as http;
import '../app/Model/BoardModel/model_board.dart';
import '../app/Model/UserModel/medel_user.dart';
import '../package/debug_console.dart';

class ServerAPIService {
  // getx singleton pattern
  static ServerAPIService get to => Get.find();
  String host = "http://129.154.214.178:3000"; // remote server
  // String host = "http://172.19.3.136:3000"; // library local

  Map<String, String> headers = {'authorization': 'Bearer unauthorized'};

  Future<void> firebaseTokenAdd() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    } else {
      return FirebaseAuth.instance.currentUser?.getIdToken().then((token) {
        headers['authorization'] = 'Bearer ' + (token ?? "unauthorized");
      });
    }
  }

  Future<dynamic> get(String url) async {
    http.Response res = await http.get(Uri.parse(host + url), headers: headers);
    return json.decode(utf8.decode(res.bodyBytes));
    // return utf8.decode(res.bodyBytes);
  }

  Future<dynamic> post(String url, Map<String, dynamic> data) async {
    log("POST ${json.encode(data)}");
    final postHeader = {'Content-Type': 'application/json'};
    postHeader.addAll(headers);

    http.Response res = await http.post(
      Uri.parse(host + url),
      body: json.encode(data),
      headers: postHeader,
    );
    return json.decode(utf8.decode(res.bodyBytes));
  }

  Future<dynamic> delete(String url) async {
    http.Response res = await http.delete(Uri.parse(host + url), headers: headers);
    return json.decode(utf8.decode(res.bodyBytes));
  }

  Future<void> fetchUserData() async {
    await firebaseTokenAdd(); // Firebase 토큰 추가

    // 내 정보 가져오기
    String meUID = FirebaseAuth.instance.currentUser!.uid ?? "";
    dynamic meData = await get("/debug/users/$meUID");
    print("My 데이터: $meData");

    // 유저 리스트 정보 가져오기
    dynamic userListData = await get("/debug/users");
    print("User List 데이터: $userListData"); // JSON 데이터 출력
    List<Users> userList = [];
    for (var userData in userListData) {
      userList.add(parseUserData(userData));
    }

    // JSON 데이터를 Users 객체로 파싱
    Users me = parseUserData(meData);

    // UserVOController에서 userVO를 가져와서 값을 설정
    UserVOController userVOController = Get.find<UserVOController>();
    userVOController.userVO.value = UserVO(me: me, userList: userList);
  }

  // JSON 데이터를 Users 객체로 파싱하는 메서드
  Users parseUserData(dynamic userData) {
    return Users(
      name: userData['name'],
      email: userData['email'],
      role: userData['role'],
    );
  }

  Future<void> fetchBoardData(Map<String, dynamic> requestData) async {
    await firebaseTokenAdd(); // Firebase 토큰 추가

    String meUID = FirebaseAuth.instance.currentUser!.uid ?? "";

    requestData["ownerFirebaseAuthUID"] = meUID;

    print("fetchBoardData: $requestData");
    try {
      dynamic boardListData = await post("/api/boards/board-all-get/", requestData);
      print("Board List 데이터 가져오기: $boardListData"); // JSON 데이터 출력
    } catch (e) {
      print("Error fetching board data: $e");
    }
  }

  Future<void> createBoardData(Map<String, dynamic> requestData) async {
    await firebaseTokenAdd(); // Firebase 토큰 추가

    String meUID = FirebaseAuth.instance.currentUser!.uid ?? "";

    BoardController boardController = Get.put(BoardController());

    requestData['ownerFirebaseAuthUID'] = meUID.toString();

    // 보드 리스트 정보 가져오기
    try {
      print("Create BoardList : $requestData");
      dynamic boardListData = await post("/api/boards/board-create/", requestData);
      print("Board List 데이터 만들기: $boardListData"); // JSON 데이터 출력
      boardController.loadBoard();
    } catch (e) {
      print("Error creating board data: $e");
    }

    // 이후 작업: boardListData를 파싱하여 Board 객체로 변환하여 리스트에 추가하는 등의 작업을 수행해야 합니다.
  }
}
