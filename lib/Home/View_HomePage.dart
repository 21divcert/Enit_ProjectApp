import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/appbar.dart';

//유저 유형
enum UserType { parent, educator, student }

// 유저 객체
class User {
  final String name;
  final String message;
  final UserType userType;
  final RxBool isPanelOpen = true.obs;

  User({required this.name, required this.message, required this.userType});
}

//
final User me =
    User(name: '나', message: '용돈 많이 주세요', userType: UserType.student);

//유저 리스트
final List<User> users = [
  User(name: '엄마', message: 'ㅎㅇ', userType: UserType.parent),
  User(name: '학원쌤', message: '숙제 ㄱㄱ', userType: UserType.educator),
  User(name: '철수', message: '인생 고달프다', userType: UserType.student),
  User(name: '훈이', message: '상남자다', userType: UserType.student),
  User(name: '아빠', message: 'ㅃ2', userType: UserType.parent),
  User(name: '담임', message: '담임입니다.예', userType: UserType.educator),
  User(name: '짱구', message: '오호', userType: UserType.student),
  User(name: '유리', message: '죽빵 맞고잡냐', userType: UserType.student),
  User(name: '맹구', message: '돌 삽니다, 팝니다.', userType: UserType.student),
  User(name: '이강인', message: '축구 힘드네', userType: UserType.student),
  User(name: '김민재', message: '쉬게 해줘..', userType: UserType.student),
  User(name: '손흥민', message: '토트넘이 좋았을 줄이야', userType: UserType.student),
  User(name: '조현우', message: '풀백 집합', userType: UserType.student),
];

String getUserTypeText(UserType userType) {
  switch (userType) {
    case UserType.parent:
      return '부모';
    case UserType.educator:
      return '선생님';
    case UserType.student:
      return '친구';
    default:
      return '알 수 없음';
  }
}

// 유저를 유형별로 정리
Map<UserType, List<User>> groupUsersByType(List<User> users) {
  Map<UserType, List<User>> grouped = {};
  for (var user in users) {
    if (!grouped.containsKey(user.userType)) {
      grouped[user.userType] = [];
    }
    grouped[user.userType]!.add(user);
  }
  return grouped;
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final Map<UserType, List<User>> groupedUsers = groupUsersByType(users);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeAppBar(),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            image: DecorationImage(
              image: AssetImage('assets/images/home_background.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.08),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: ListView(
            children: [
              UserListView(user: me),
              ...groupedUsers.entries
                  .map(
                    (entry) =>
                        _buildUserTypePanel(context, entry.key, entry.value),
                  )
                  .toList(),
            ],
          ),
        ));
  }

  Widget _buildUserTypePanel(
      BuildContext context, UserType userType, List<User> userList) {
    if (userType == UserType.student && userList.contains(me)) {
      return SizedBox.shrink();
    }

    return Obx(() {
      return ExpansionTile(
        initiallyExpanded: userList[0].isPanelOpen.value,
        title: Text(getUserTypeText(userType)),
        onExpansionChanged: (isOpen) {
          userList[0].isPanelOpen.value = isOpen;
        },
        children: userList.map((user) => UserListView(user: user)).toList(),
      );
    });
  }
}

class UserListView extends StatelessWidget {
  final User user;

  UserListView({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(
            'assets/images/happy.png'), // 사용자의 프로필 이미지 나중에 객체로 받아와서 넣어줄 것
      ),
      title: Text(user.name),
      subtitle: Text(user.message),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 이미지 버튼
          IconButton(
            icon: Icon(Icons.content_paste), // 버튼에 들어갈 이미지 경로 넣어줘야됨
            onPressed: () {
              // 클릭 이벤트 비워둠
            },
          ),
          // 인버트 모어 아이콘 버튼
          IconButton(
            icon: Icon(Icons.more_vert), // 인버트 모어 아이콘
            onPressed: () {
              // 클릭 이벤트 비워둠
            },
          ),
        ],
      ),
      onTap: () {
        // 사용자 클릭 시 이벤트
      },
    );
  }
}
