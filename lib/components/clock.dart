import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  final double fontSize;

  Clock({
    this.fontSize = 24,
  });

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  final _dateFormat = DateFormat('yyyy년 MM월 dd일 hh:mm');
  bool _isAfterNoon;
  Timer _timer;
  String _text = '';

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      Duration(milliseconds: (1000 / 1).round()),
      (timer) {
        tick();
      },
    );

    tick();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        _isAfterNoon ? '$_text PM' : '$_text AM',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.black, fontSize: 18),
      ),
    );
  }

  tick() {
    final now = DateTime.now();
    setState(() {
      _text = _dateFormat.format(now);
      _isAfterNoon = now.hour > 12 ? true : false;
    });
  }
}
