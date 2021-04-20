import 'package:flutter/material.dart';

class DeviceView extends StatefulWidget {
  DeviceView({Key key}) : super(key: key);

  @override
  _DeviceViewState createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Text('1'),
    );
  }
}
