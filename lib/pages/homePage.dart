import 'package:flutter/material.dart';
import 'package:h_order_reception/components/customBar.dart';
import 'package:h_order_reception/pages/history/historyView.dart';
import 'package:h_order_reception/pages/home/orderView.dart';

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
      length: 2,
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
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            CustomBar(
              index: _tabController.index,
              callback: (int index) {
                _tabController.index = index;
                setState(() {});
              },
            ),
            _views(),
          ],
        ),
      ),
    );
  }

  _tabs() => Container(
        color: Theme.of(context).accentColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(_tabList.length, (index) => Text('index')),
        ),
      );

  _views() => Expanded(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            OrderView(),
            HistoryView(),
          ],
        ),
      );
}
