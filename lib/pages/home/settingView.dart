import 'package:flutter/material.dart';
import 'package:h_order_reception/appRouter.dart';

class SettingView extends StatefulWidget {
  SettingView({Key key}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  String selectedListType = "Grid";

  int orderCount = 6;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 50,
            child: RaisedButton(
              onPressed: () {
                AppRouter.toLoginPage();
              },
              child: Text(
                '로그아웃',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
