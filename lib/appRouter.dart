import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/routeNames.dart';
import 'package:h_order_reception/pages/history/historyPage.dart';
import 'package:h_order_reception/pages/homePage.dart';
import 'package:h_order_reception/pages/loginPage.dart';
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

      case RouteNames.History:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) =>
              HistoryPage(orderObjectId: settings.arguments as String),
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

  static toHistoryPage(String orderObjectId) {
    Navigator.of(context)
        .pushNamed(RouteNames.History, arguments: orderObjectId);
  }
}
