import 'dart:async';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  final DateTime dateTime;

  Clock({
    this.dateTime,
  });

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Timer timer;

  @override
  void initState() {
    super.initState();

    timer =
        Timer.periodic(Duration(milliseconds: (1000 / 10).floor()), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = DateTime.now().difference(widget.dateTime);
    final seconds = duration.inSeconds;
    final h = (seconds / 3600).floor();
    final hh = h < 10 ? '0$h' : '$h';

    final m = (seconds % 3600 / 60).floor();
    final mm = m < 10 ? '0$m' : '$m';

    final s = (seconds % 60).floor();
    final ss = s < 10 ? '0$s' : '$s';

    final text = "$hh:$mm:$ss";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      alignment: Alignment.center,
      child: Text(
        '$text',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
