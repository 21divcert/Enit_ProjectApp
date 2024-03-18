import 'package:flutter/material.dart';
import '../../Model/UserModel/medel_user.dart';

class ProfileBottomSheet {
  static void showProfileBottomSheet(BuildContext context, Users selectedUser) {
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
                selectedUser.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                selectedUser.email, // Assuming email is used instead of message
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildButtons(context, selectedUser),
              ),
            ],
          ),
        );
      },
    );
  }

  static List<Widget> _buildButtons(BuildContext context, Users selectedUser) {
    final buttons = <Widget>[];

    buttons.addAll([
      ElevatedButton(
        onPressed: () {
          // "프로필 수정" 버튼 클릭 시 동작
          // You can add the logic for profile editing here
        },
        child: Text('프로필 수정'),
      ),
      ElevatedButton(
        onPressed: () {
          // "로그아웃" 버튼 클릭 시 동작
          // You can add the logic for logging out here
        },
        child: Text('로그아웃'),
      ),
    ]);

    buttons.add(
      ElevatedButton(
        onPressed: () {
          // "닫기" 버튼 클릭 시 동작
          Navigator.of(context).pop();
        },
        child: Text('닫기'),
      ),
    );

    return buttons;
  }
}
