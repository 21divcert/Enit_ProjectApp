import 'package:flutter/material.dart';

class GrassPage extends StatelessWidget {
  const GrassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xfff3f7d7), // 배경 색상
          image: DecorationImage(
            image: AssetImage('assets/images/home_background.png'), // 배경 이미지
            fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 조절
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.08), // 이미지에 흰색을 8% 불투명도로 오버레이
              BlendMode.dstATop, // 이미지 위에 색상을 덮음
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
                height: kToolbarHeight + MediaQuery.of(context).padding.top),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProfilePictureWidget(), // 프로필 사진 및 닉네임 위젯
            ),
            // 3개의 빈 카드 컨테이너
            for (int i = 0; i < 3; i++)
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Container(
                  height: 100, // 높이는 원하는대로 조절
                  // 내부에 더 많은 위젯을 배치할 수 있음
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            'assets/images/happy.png',
            width: 85,
            height: 85,
          ),
        ),
        const SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '',
              style: TextStyle(
                color: Colors.white.withOpacity(.9),
                fontSize: 15,
              ),
            ),
            Text(
              '나',
              style: TextStyle(
                color: Colors.white,
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
