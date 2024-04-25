import 'package:enit_project_app/service/auth_service.dart';
import 'package:enit_project_app/service/server_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'app/Board/view/view_boardpage.dart';
import 'app/Grasspage/view/view_grasspage.dart';
import 'app/Home/view/view_homepage.dart';
import 'app/Login/Login/view/view_loginpage.dart';
import 'app/Root/RootPage.dart';
import 'app/utils/tabs.dart';
import 'firebase_options.dart';
import 'package/debug_console.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //파이어베이스 연동
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  enableDebug();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'SKYBORI'),
      themeMode: ThemeMode.system,
      initialBinding: BindingsBuilder(
        () async {
          Get.put(AuthService());
          Get.put(ServerAPIService());
        },
      ),
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/board', page: () => BoardPage()),
        GetPage(name: '/grass', page: () => GrassPage()),
      ],
      initialRoute: '/login',
      home: RootPage(),
      builder: EasyLoading.init(),
    );
  }
}
