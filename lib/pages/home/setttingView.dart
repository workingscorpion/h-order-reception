import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/store/userInfoStore.dart';

class SettingView extends StatefulWidget {
  SettingView({Key key}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  UserInfoStore userInfoStore = UserInfoStore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: OutlineButton(
              onPressed: () => userInfoStore.logout(),
              child: Text(
                '로그아웃',
                style: TextStyle(color: Colors.black),
              ),
              borderSide: BorderSide(color: CustomColors.aBlack, width: 1),
            ),
          ),
          Divider(
            color: CustomColors.tableInnerBorder,
            height: 50,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
