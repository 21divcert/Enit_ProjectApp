import 'package:enit_project_app/Home/view_homepage.dart';
import 'package:enit_project_app/app/Home/view_homepage.dart';
import 'package:flutter/material.dart';

class ProfileBottomSheet {
  static void showProfileBottomSheet(BuildContext context, User user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/happy.png'),
                radius: 50,
              ),
              SizedBox(height: 16.0),
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                user.message,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildButtons(context, user),
              ),
            ],
          ),
        );
      },
    );
  }

  static List<Widget> _buildButtons(BuildContext context, User user) {
    final buttons = <Widget>[];

    if (user == me) {
      buttons.addAll([
        ElevatedButton(
          onPressed: () {
            // "프로필 수정" 버튼 클릭 시 동작
          },
          child: Text('프로필 수정'),
        ),
        ElevatedButton(
          onPressed: () {
            // "로그아웃" 버튼 클릭 시 동작
          },
          child: Text('로그아웃'),
        ),
      ]);
    } else {
      buttons.addAll([
        ElevatedButton(
          onPressed: () {
            // "보드 보기" 버튼 클릭 시 동작
          },
          child: Text('보드 보기'),
        ),
        ElevatedButton(
          onPressed: () {
            // "친구 삭제" 버튼 클릭 시 동작
          },
          child: Text('친구 삭제'),
        ),
      ]);
    }

    buttons.add(
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('닫기'),
      ),
    );

    return buttons;
  }
}
