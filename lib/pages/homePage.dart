import 'package:flutter/material.dart';
import 'package:h_order_reception/appRouter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        // body: Container(
        //   child: Text('home'),
        // ),
        body: RaisedButton(
          onPressed: () => {AppRouter.toLockPage()},
          child: Text('123'),
        ),
      ),
    );
  }
}
