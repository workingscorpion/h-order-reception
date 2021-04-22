import 'package:flutter/material.dart';
import 'package:h_order_reception/appRouter.dart';

class OrderPage extends StatefulWidget {
  OrderPage({this.orderObjectId});

  final String orderObjectId;

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();

    // _load();
  }

  // _load() async {
  //   // TODO: get Data
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _header(),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  _header() => Container(
        child: Row(
          children: [
            BackButton(
              onPressed: () => AppRouter.pop(),
            ),
            Spacer(),
            Text('주문현황'),
            Spacer(),
          ],
        ),
      );

  _body() => Expanded(
        child: Container(
          child: Text('body'),
        ),
      );
}
