import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/routeNames.dart';
import 'package:h_order_reception/pages/homePage.dart';
import 'package:h_order_reception/pages/lockPage.dart';
import 'package:h_order_reception/pages/login.dart';
import 'package:h_order_reception/pages/splashPage.dart';
import 'package:h_order_reception/store/navigationStore.dart';

class AppRouter {
  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.Splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => SplashPage(),
        );

      case RouteNames.Lock:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => LockPage(),
        );

      case RouteNames.Login:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => LoginPage(),
        );

      case RouteNames.Home:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => HomePage(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => SplashPage(),
        );
    }
  }

  static get context => NavigationStore.instance.navigatorKey.currentContext;

  static pop() {
    return Navigator.of(context).pop();
  }

  static toHomePage() {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(RouteNames.Home, (Route route) => false);
  }

  static toLoginPage() {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(RouteNames.Login, (Route route) => false);
  }

  static toLockPage() {
    return Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.Lock,
      (route) => route.settings.name != RouteNames.Lock,
    );
  }
}
