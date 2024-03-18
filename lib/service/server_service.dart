import 'dart:convert';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:http/http.dart" as http;
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

  Future<dynamic> post(String url, Map<String, String> data) async {
    // debugConsole(json.encode(data));
    http.Response res = await http.post(
      Uri.parse(host + url),
      body:
          data, //////// VERY IMPORTANT : DO NOT PASS the map data like json.encode(data) !!!! /////////
      headers: headers,
    );
    return json.decode(utf8.decode(res.bodyBytes));
    // return utf8.decode(res.bodyBytes);
  }

  Future<dynamic> delete(String url) async {
    http.Response res =
        await http.delete(Uri.parse(host + url), headers: headers);
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
}
