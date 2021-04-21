import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const IdKey = 'ID';
  bool initialized = false;

  @override
  void initState() {
    initialize();

    super.initState();
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String id = prefs.getString(IdKey);
      if (id == 'djdj159') {
        AppRouter.toHomePage();
      }

      if (id == null) {
        throw Exception();
      }

      // await _userInfoStore.login(id: id);

      // FIXME
      AppRouter.toLoginPage();
      // await loadInfo();
    } catch (ex) {
      // AppRouter.toLoginPage();
    }
  }

  loadInfo() async {
    try {
      // await _hotelInfoStore.loadHotels();
      // await _hotelInfoStore.selectHotel(_hotelInfoStore.hotelList.first);
      // AppRouter.toHomePage();
    } catch (ex) {
      // AppRouter.toHotelSelectPage();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: _Logo(),
      );
}

class _Logo extends StatelessWidget {
  const _Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset('assets/logo.svg'),
    );
  }
}
