import 'package:enit_project_app/app/Home/controller/control_homepage.dart';
import '../../../service/server_service.dart';
import 'package:get/get.dart';

// 1. Get 메소드를 사용하여 서버에서 데이터를 가져옴
// 2. 서버에서 가져온 데이터를 JSON 형식으로 저장할 변수 필요
// 3. 변수 파싱해서 유저정보에 대한 VO 클래스 생성
// 4. VO 클래스를 사용하여 내 정보, 다른 유저의 정보를 가져올 수 있도록 구현
// 5. 받아온 데이터를 화면에 출력 테스트
// 6. 정상적이라면 HomePage 바인딩해보기

// 유저 객체

class Users {
  final String name;
  final String email;
  final String role;
  bool isPanelOpen; // 추가: 패널 열림 여부

  Users({
    required this.name,
    required this.email,
    required this.role,
    this.isPanelOpen = false,
  });
}

class UserVO {
  late final Users me;
  late final List<Users> userList;

  UserVO({
    required this.me,
    required this.userList,
  });
}

class UserVOController extends GetxController {
  final Rx<UserVO?> userVO = Rx<UserVO?>(null);
  final ServerAPIService _apiService = ServerAPIService.to;

  Future<void> loadUserData() async {
    try {
      await _apiService.fetchUserData();
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
}
