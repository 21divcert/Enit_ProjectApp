import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  void handleSearchIconPressed() {
    // 검색 아이콘 클릭 시 수행할 동작
  }

  void handleAddFriendIconPressed() {
    // 친구 추가 아이콘 클릭 시 수행할 동작
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        '친구',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            handleSearchIconPressed();
          },
        ),
        IconButton(
          icon: Icon(Icons.person_add),
          onPressed: () {
            handleAddFriendIconPressed();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}
