import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/constants/routeNames.dart';
import 'package:h_order_reception/store/navigationStore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  App({
    Key key,
  }) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> with WidgetsBindingObserver {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseAnalytics analytics = FirebaseAnalytics();
  FirebaseAnalyticsObserver observer;

  ThemeMode _themeMode = ThemeMode.light;
  Brightness _brightness = Brightness.light;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initTheme();
    initFirebaseAnalytics();
  }

  initFirebaseAnalytics() {
    observer = FirebaseAnalyticsObserver(analytics: analytics);
  }

  @override
  void dispose() {
    super.dispose();
  }

  initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isLightMode = prefs.getBool('LightMode') ?? true;
    setThemes(isLightMode);
  }

  setThemes(bool isLightMode) {
    _themeMode = isLightMode ? ThemeMode.light : ThemeMode.dark;
    _brightness = isLightMode ? Brightness.light : Brightness.dark;
    setState(() {});
  }

  setTheme(bool isLightMode) async {
    final prefs = await SharedPreferences.getInstance();
    setThemes(isLightMode);
    prefs.setBool('LightMode', isLightMode);
  }

  Future<bool> isLightMode() async {
    return _themeMode == ThemeMode.light;
  }

  _iconTheme(bool isLightMode) => IconThemeData(
        color: isLightMode ? CustomColors.aBlack : CustomColors.aWhite,
      );

  _textTheme(bool isLightMode) {
    final textColor = isLightMode ? CustomColors.aBlack : CustomColors.aWhite;
    final subTextColor1 =
        isLightMode ? CustomColors.subTextBlack : CustomColors.aWhite;
    final subTextColor2 =
        isLightMode ? CustomColors.textBlack : CustomColors.aWhite;

    return TextTheme(
      headline1: TextStyle(
        fontSize: 60,
        color: textColor,
      ),
      headline2: TextStyle(
        fontSize: 20,
        color: subTextColor1,
      ),
      headline3: TextStyle(
        fontSize: 20,
        color: isLightMode ? CustomColors.aWhite : CustomColors.subTextBlack,
      ),
      headline4: TextStyle(
        fontSize: 20,
        color: subTextColor2,
      ),
      headline5: TextStyle(
        fontSize: 20,
        color: subTextColor2,
      ),
      headline6: TextStyle(
        fontSize: 20,
        color: subTextColor2,
      ),
      bodyText1: TextStyle(
        fontSize: 20,
        color: isLightMode ? CustomColors.aWhite : CustomColors.aBlack,
      ),
      bodyText2: TextStyle(
        fontSize: 20,
        color: isLightMode ? CustomColors.aBlack : CustomColors.aWhite,
      ),
      subtitle1: TextStyle(
        fontSize: 20,
        color: subTextColor2,
      ),
      subtitle2: TextStyle(
        fontSize: 20,
        color: subTextColor2,
      ),
      button: TextStyle(
        fontSize: 20,
        color: subTextColor2,
      ),
      caption: TextStyle(
        fontSize: 20,
        color: subTextColor2,
      ),
      overline: TextStyle(
        fontSize: 20,
        color: subTextColor2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H Order Reception',
      themeMode: _themeMode,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      navigatorKey: NavigationStore.instance.navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RouteNames.Splash,
    );
  }

  _lightTheme() => ThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        accentColor: Colors.black,
        primaryColor: Colors.white,
        backgroundColor: CustomColors.backgroundLightGrey,
        dialogBackgroundColor: CustomColors.backgroundLightGrey,
        scaffoldBackgroundColor: CustomColors.backgroundLightGrey,
        splashColor: Colors.transparent,
        textTheme: _textTheme(true),
        primaryTextTheme: _textTheme(true),
        accentTextTheme: _textTheme(true),
        iconTheme: _iconTheme(true),
        primaryIconTheme: _iconTheme(true),
        bottomAppBarColor: CustomColors.tableInnerBorder,
        accentIconTheme: _iconTheme(true),
        buttonColor: Colors.blueGrey,
        colorScheme: ColorScheme(
          primary: CustomColors.aWhite,
          primaryVariant: CustomColors.backgroundLightGrey,
          secondary: Colors.blue,
          secondaryVariant: CustomColors.backgroundLightGrey,
          surface: CustomColors.backgroundLightGrey,
          background: CustomColors.backgroundLightGrey,
          error: Colors.red,
          onPrimary: CustomColors.backgroundLightGrey,
          onSecondary: CustomColors.aWhite,
          onSurface: CustomColors.aWhite,
          onBackground: CustomColors.aWhite,
          onError: Colors.red,
          brightness: _brightness,
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.black87,
          ),
          textStyle: TextStyle(
            color: CustomColors.aWhite,
          ),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.white24,
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            side: BorderSide(
              width: 1,
            ),
          ),
          padding: EdgeInsets.zero,
          splashColor: Colors.transparent,
          buttonColor: CustomColors.aBlack,
        ),
        buttonBarTheme: ButtonBarThemeData(
          buttonPadding: EdgeInsets.zero,
          alignment: MainAxisAlignment.center,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            textStyle: TextStyle(
              color: CustomColors.aBlack,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: CustomColors.aBlack,
            side: BorderSide(
              width: 1,
              color: CustomColors.aWhite,
            ),
            padding: EdgeInsets.zero,
            elevation: 0,
            textStyle: TextStyle(
              color: CustomColors.aBlack,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            elevation: 0,
            textStyle: TextStyle(
              color: CustomColors.aBlack,
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: CustomColors.backgroundDarkGrey,
          foregroundColor: CustomColors.aWhite,
        ),
        tabBarTheme: TabBarTheme(
          labelPadding: EdgeInsets.symmetric(horizontal: 20),
          labelColor: CustomColors.aWhite,
          labelStyle: TextStyle(
            fontSize: 20,
            color: CustomColors.aBlack,
          ),
          unselectedLabelColor: CustomColors.aWhite,
          unselectedLabelStyle: TextStyle(
            fontSize: 20,
            color: CustomColors.aBlack,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: CustomColors.backgroundLightGrey,
          elevation: 0,
          centerTitle: true,
          shadowColor: Colors.transparent,
          textTheme: _textTheme(true),
          iconTheme: _iconTheme(true),
          actionsIconTheme: _iconTheme(true),
          brightness: _brightness,
        ),
      );

  _darkTheme() => ThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        accentColor: CustomColors.aWhite,
        primaryColor: Colors.black,
        backgroundColor: CustomColors.backgroundDarkGrey,
        dialogBackgroundColor: CustomColors.backgroundDarkGrey,
        scaffoldBackgroundColor: CustomColors.backgroundDarkGrey,
        splashColor: Colors.transparent,
        textTheme: _textTheme(false),
        primaryTextTheme: _textTheme(false),
        accentTextTheme: _textTheme(false),
        iconTheme: _iconTheme(false),
        primaryIconTheme: _iconTheme(false),
        accentIconTheme: _iconTheme(false),
        bottomAppBarColor: CustomColors.tableInnerBorder,
        buttonColor: Colors.blueGrey,
        colorScheme: ColorScheme(
          primary: CustomColors.aWhite,
          primaryVariant: CustomColors.backgroundDarkGrey,
          secondary: Colors.blue,
          secondaryVariant: CustomColors.backgroundDarkGrey,
          surface: CustomColors.backgroundDarkGrey,
          background: CustomColors.backgroundDarkGrey,
          error: Colors.red,
          onPrimary: CustomColors.backgroundDarkGrey,
          onSecondary: CustomColors.aWhite,
          onSurface: CustomColors.aWhite,
          onBackground: CustomColors.aWhite,
          onError: Colors.red,
          brightness: _brightness,
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.black87,
          ),
          textStyle: TextStyle(
            color: CustomColors.aWhite,
          ),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.white24,
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            side: BorderSide(
              width: 1,
              color: CustomColors.aWhite,
            ),
          ),
          padding: EdgeInsets.zero,
          splashColor: Colors.transparent,
        ),
        buttonBarTheme: ButtonBarThemeData(
          buttonPadding: EdgeInsets.zero,
          alignment: MainAxisAlignment.center,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            textStyle: TextStyle(
              color: CustomColors.aWhite,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              width: 1,
              color: CustomColors.aWhite,
            ),
            padding: EdgeInsets.zero,
            elevation: 0,
            textStyle: TextStyle(
              color: CustomColors.aWhite,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            textStyle: TextStyle(
              color: CustomColors.aWhite,
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: CustomColors.backgroundLightGrey,
          foregroundColor: CustomColors.aBlack,
        ),
        tabBarTheme: TabBarTheme(
          labelPadding: EdgeInsets.symmetric(horizontal: 20),
          labelColor: CustomColors.aWhite,
          labelStyle: TextStyle(
            fontSize: 20,
            color: CustomColors.aWhite,
          ),
          unselectedLabelColor: CustomColors.aWhite,
          unselectedLabelStyle: TextStyle(
            fontSize: 20,
            color: CustomColors.aWhite,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: CustomColors.backgroundDarkGrey,
          elevation: 0,
          centerTitle: true,
          shadowColor: Colors.transparent,
          textTheme: _textTheme(false),
          iconTheme: _iconTheme(false),
          actionsIconTheme: _iconTheme(false),
          brightness: _brightness,
        ),
      );
}
