import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/pages/home/orderView.dart';

import 'home/deviceView.dart';
import 'home/settingView.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<String> _tabList = ['Apply', 'Device', 'Setting'];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      initialIndex: 0,
      length: 3,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Container(
        child: Row(
          children: [
            _tabs(),
            _views(),
          ],
        ),
      )),
    );
  }

  _tabButton(int index) => GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
          setState(() {});
        },
        child: Container(
          alignment: Alignment.center,
          height: 100,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: CustomColors.tableInnerBorder),
            ),
            color: _tabController.index == index
                ? CustomColors.selectedItemColor
                : Theme.of(context).accentColor,
          ),
          child: Text(
            '${_tabList[index]}',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 30,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
          ),
        ),
      );

  _tabs() => Expanded(
        child: Container(
          color: Theme.of(context).accentColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:
                List.generate(_tabList.length, (index) => _tabButton(index)),
          ),
        ),
      );

  _views() => Expanded(
        flex: 5,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            OrderView(),
            DeviceView(),
            SettingView(),
          ],
        ),
      );
}
