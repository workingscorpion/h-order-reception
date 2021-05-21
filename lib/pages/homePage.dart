import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order_reception/components/customBar.dart';
import 'package:h_order_reception/pages/history/historyView.dart';
import 'package:h_order_reception/pages/home/orderView.dart';
import 'package:h_order_reception/store/historyStore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final icons = [
    CupertinoIcons.home,
    CupertinoIcons.time,
  ];

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      initialIndex: 0,
      length: icons.length,
    );

    _tabController.addListener(() {
      setState(() {});
    });

    // HistoryStore.instance.connectHub();

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              CustomBar(
                controller: _tabController,
                icons: icons,
              ),
              _views(),
            ],
          ),
        ),
      ),
    );
  }

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
