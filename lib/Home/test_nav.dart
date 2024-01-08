import 'package:enit_project_app/Login/View_MyHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class NavigatorPage extends StatelessWidget {
  final Routes routes;
  final IconData navIcon;
  final String navLabel;
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  NavigatorPage(
      {Key? key,
      required this.routes,
      required this.navIcon,
      required this.navLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 여기에 NavigatorPage의 UI를 구현합니다.
    // 예를 들어, Navigator 위젯을 사용할 수 있습니다.
    return Navigator(
      key: navKey,
      onGenerateRoute: routes.getRoute,
    );
  }
}

abstract class Routes {
  Route<dynamic> getRoute(RouteSettings settings);
}

class HomeRoute implements Routes {
  @override
  Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'aa',
                )); // 예시 페이지
      case 'home2':
        // 다른 페이지로 대체
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'aa',
                ));
      case 'home3':
        // 다른 페이지로 대체
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'aa',
                ));
      case 'home4':
        // 다른 페이지로 대체
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'aa',
                ));
      case 'home5':
        // 다른 페이지로 대체
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'aa',
                ));
      case 'home6':
        // 다른 페이지로 대체
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'aa',
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name} does not exist'),
            ),
          ),
        );
    }
  }
}

class SettingRoute implements Routes {
  @override
  Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'aa',
                )); // 설정 페이지
      case 'settings2':
        // 다른 설정 페이지로 대체
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'aa',
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name} does not exist'),
            ),
          ),
        );
    }
  }
}

class BottomBarController extends ChangeNotifier {
  late final List<NavigatorPage> _navPages;

  List<NavigatorPage> get navPages => _navPages;

  int _currentTab = 0;

  int get currentTab => _currentTab;

  NavigatorPage get currentNavigatorPage => navPages[_currentTab];

  void init() {
    _navPages = [
      NavigatorPage(
          routes: HomeRoute(),
          navLabel: 'Explore',
          navIcon: Icons.compass_calibration),
      NavigatorPage(
          routes: SettingRoute(), navLabel: 'Setting', navIcon: Icons.settings),
    ];
  }

  void changeTab(int index) {
    if (index != _currentTab) {
      _currentTab = index;
      notifyListeners();
    }
  }
}

class NavBody extends StatelessWidget {
  const NavBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bottomController = BottomBarController()..init();

    return WillPopScope(
      onWillPop: () async {
        NavigatorState? currentNavState =
            bottomController.currentNavigatorPage.navKey.currentState;
        if (currentNavState?.canPop() ?? false) {
          currentNavState?.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: AnimatedBuilder(
          animation: bottomController,
          builder: (context, child) {
            return IndexedStack(
              index: bottomController.currentTab,
              children: bottomController.navPages
                  .map((page) => Navigator(
                        key: page.navKey,
                        onGenerateRoute: page.routes.getRoute,
                      ))
                  .toList(),
            );
          },
        ),
        bottomNavigationBar:
            BottomBarWidget(bottomController: bottomController),
      ),
    );
  }
}

class BottomBarWidget extends StatelessWidget {
  final BottomBarController bottomController;

  BottomBarWidget({Key? key, required this.bottomController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bottomController,
      builder: (context, child) {
        return BottomNavigationBar(
          onTap: bottomController.changeTab,
          currentIndex: bottomController.currentTab,
          items: bottomController.navPages
              .map((page) => BottomNavigationBarItem(
                  icon: Icon(page.navIcon), label: page.navLabel))
              .toList(),
        );
      },
    );
  }
}
