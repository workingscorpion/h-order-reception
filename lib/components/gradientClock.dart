import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GradientClock extends StatefulWidget {
  GradientClock({this.startColor, this.endColor});

  final Color startColor;
  final Color endColor;

  @override
  _GradientClockState createState() => _GradientClockState();
}

class _GradientClockState extends State<GradientClock> {
  Timer _timer;
  String _timeString;
  int hour;
  String timeString;
  bool isAfterNoon;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if (mounted) {
      setState(() {
        _timeString = formattedDateTime;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDateTime(DateTime dateTime) {
    timeString = DateFormat('hh:mm').format(dateTime);
    isAfterNoon = dateTime.hour > 12;
    return DateFormat('yyyy년 MM월 dd일').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _gradientDecoration(),
      child: _circle(),
    );
  }

  _gradientDecoration() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [
            0.1,
            0.8,
          ],
          colors: [
            widget.startColor,
            widget.endColor,
          ],
        ),
      );

  _circle() => Container(
        margin: EdgeInsets.all(100),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            width: 11,
            color: Colors.white,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _clockTemperature(),
              _clockTexts(
                text: isAfterNoon ? "PM" : "AM",
                margin: EdgeInsets.only(top: 50),
                fontSize: 36,
              ),
              _clockTexts(
                text: '$timeString',
                margin: EdgeInsets.only(top: 10),
                fontSize: 124,
                fontWeight: FontWeight.w100,
              ),
              _clockTexts(
                text: _timeString,
                margin: EdgeInsets.only(top: 30),
                fontSize: 28,
              ),
            ],
          ),
        ),
      );

  _clockTemperature() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '서울 / 28℃',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Icon(
              CupertinoIcons.cloud_sun,
              size: 74,
              color: Colors.white,
            ),
          ),
        ],
      );

  _clockTexts({
    String text,
    double fontSize,
    EdgeInsets margin,
    FontWeight fontWeight,
  }) =>
      Container(
        margin: margin,
        child: Text(
          text,
          style: TextStyle(
            height: 1,
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      );
}
