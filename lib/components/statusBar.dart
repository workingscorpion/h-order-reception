import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h_order_reception/components/clock.dart';
import 'package:battery/battery.dart';
import 'package:wifi/wifi.dart';

class StatusBar extends StatefulWidget {
  StatusBar({Key key}) : super(key: key);

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  static const max = 100;
  static const maxCount = 5;

  final _battery = Battery();

  BatteryState _batteryState;
  int _wifiLevel = 0;
  int _batteryLevel = 0;

  StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    super.initState();

    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState event) {
      _batteryState = event;
      setState(() {});
    });

    _getBatteryLevel();
    _getWifiLevel();

    Timer.periodic(new Duration(minutes: 1), (timer) {
      _getBatteryLevel();
      setState(() {});
    });

    Timer.periodic(new Duration(seconds: 30), (timer) {
      _getWifiLevel();
      setState(() {});
    });
  }

  _getBatteryLevel() {
    _battery.batteryLevel.then((value) {
      _batteryLevel = value;
      setState(() {});
    });
  }

  _getWifiLevel() {
    Wifi.level.then((value) {
      _wifiLevel = value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _batteryStateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: .5,
            color: Colors.black26,
          ),
        ),
      ),
      child: Row(
        children: [
          Clock(
            fontSize: 24,
          ),
          Spacer(),
          _wifiInidicator(),
          _batteryIndicator(),
        ],
      ),
    );
  }

  _wifiInidicator() => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 5),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          _getWifiImage(_wifiLevel),
          height: 17,
        ),
      );

  _getWifiImage(int level) {
    switch (level) {
      case 0:
        return 'assets/icons/statusbar/wifi_0.svg';

      case 1:
        return 'assets/icons/statusbar/wifi_1.svg';

      case 2:
        return 'assets/icons/statusbar/wifi_2.svg';

      case 3:
        return 'assets/icons/statusbar/wifi_3.svg';

      default:
        return 'assets/icons/statusbar/wifi_0.svg';
    }
  }

  _batteryIndicator() => Container(
        child: SvgPicture.asset(
          _getBatteryImage(_batteryLevel),
        ),
      );

  _getBatteryImage(int level) {
    final battery = (level / (max / (maxCount - 1))).floor();
    final keyword = _batteryState == BatteryState.charging ? "charging_" : "";

    switch (battery) {
      case 0:
        return 'assets/icons/statusbar/${keyword}battery_0.svg';

      case 1:
        return 'assets/icons/statusbar/${keyword}battery_1.svg';

      case 2:
        return 'assets/icons/statusbar/${keyword}battery_2.svg';

      case 3:
        return 'assets/icons/statusbar/${keyword}battery_3.svg';

      case 4:
        return 'assets/icons/statusbar/${keyword}battery_4.svg';

      default:
        return 'assets/icons/statusbar/${keyword}battery_0.svg';
    }
  }
}
