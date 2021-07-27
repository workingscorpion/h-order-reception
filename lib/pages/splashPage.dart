import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/store/userInfoStore.dart';
import 'package:h_order_reception/utils/sharedPreferencesHelper.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String versionNumber = '';
  bool initialized = false;

  @override
  void initState() {
    initialize();
    _getVersion();

    super.initState();
  }

  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionNumber = packageInfo.version;
    setState(() {});
  }

  initialize() async {
    final timer = Timer(Duration(seconds: 2), () async {
      if (initialized) {
        await autoLogin();
        // _userInfoStore.isInitialized = true;
      }
    });

    try {
      initialized = false;

      await initializeDateFormatting('ko');
      Intl.defaultLocale = 'ko';

      WidgetsFlutterBinding.ensureInitialized();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      initialized = true;
    } finally {
      if (!timer.isActive) {
        await autoLogin();

        // _userInfoStore.isInitialized = true;
      }
    }
  }

  autoLogin() async {
    try {
      final String id = await SharedPreferencesHelper.getUserId();

      if (id == null) {
        throw Exception();
      }

      await UserInfoStore.instance.login(id: id);

      AppRouter.toHomePage();
    } catch (ex) {
      AppRouter.toLoginPage();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _Logo(),
          Positioned(
            bottom: 0,
            left: 0,
            child: Text(
              'Version: $versionNumber',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ));
}

class _Logo extends StatelessWidget {
  const _Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: _gradient(),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/logo.svg',
        height: 100,
      ),
    );
  }

  _gradient() => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [
          0.1,
          1,
        ],
        colors: [
          CustomColors.gradientTopColor,
          CustomColors.gradientBottomColor,
        ],
      );
}
