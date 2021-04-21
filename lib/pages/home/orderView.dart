import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/menuModel.dart';
import 'package:h_order_reception/model/orderModel.dart';
import 'package:intl/intl.dart';

class OrderView extends StatefulWidget {
  OrderView({Key key}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int itemCount = 3;

  List<OrderModel> list = List();

  List<OrderModel> orders = [
    OrderModel(
      objectId: '1',
      status: 0,
      applyTime: DateTime.now().subtract(Duration(minutes: 20)),
      roomNumber: '12',
      shopName: ' 던킨 도넛',
      menus: [],
    ),
    OrderModel(
      objectId: '2',
      status: 0,
      applyTime: DateTime.now().subtract(Duration(minutes: 20)),
      roomNumber: '12',
      shopName: ' 던킨 도넛',
      menus: [],
    ),
    OrderModel(
      objectId: '3',
      status: 0,
      applyTime: DateTime.now().subtract(Duration(minutes: 20)),
      roomNumber: '12',
      shopName: ' 던킨 도넛',
      menus: [],
    ),
  ];

  List<MenuModel> menus = [
    MenuModel(
      boundaryId: '11',
      count: 1,
      name: 'test1',
      objectId: '111',
      price: 1000,
    ),
    MenuModel(
      boundaryId: '11',
      count: 2,
      name: 'test2',
      objectId: '222',
      price: 3500,
    ),
  ];

  @override
  void initState() {
    super.initState();

    list = orders
        .map((e) => OrderModel(
              objectId: e.objectId,
              status: e.status,
              applyTime: e.applyTime,
              roomNumber: e.roomNumber,
              shopName: e.shopName,
              menus: menus,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
            children:
                List.generate(list.length, (index) => _item(list[index]))));
  }

  _item(OrderModel item) => DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2,
        child: Container(
          height: MediaQuery.of(context).size.height * .18,
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: CustomColors.tableInnerBorder, width: 1),
          )),
          child: Stack(
            children: [
              Row(
                children: [
                  _itemTime(item.applyTime),
                  _itemInfo(item),
                  _itemButtons(item.objectId),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Text('${DateFormat("yy/MM/dd").format(item.applyTime)}'),
              )
            ],
          ),
        ),
      );

  _itemTime(DateTime time) => Expanded(
        flex: 2,
        child: Container(child: Text('${DateFormat("hh:mm").format(time)}')),
      );

  _itemInfo(OrderModel item) => Expanded(
        flex: 3,
        child: Container(),
      );
  _itemButtons(String orderId) => Expanded(
        flex: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 30),
                child: _itemButton(
                  text: '거절',
                  background: CustomColors.tableInnerBorder,
                  onTap: () {},
                ),
              ),
              _itemButton(
                text: '완료',
                background: CustomColors.selectedItemColor,
                onTap: () {},
              ),
            ],
          ),
        ),
      );

  _itemButton({String text, Color background, Function onTap}) =>
      GestureDetector(
        child: AspectRatio(
          aspectRatio: 4 / 5,
          child: Container(
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
            ),
          ),
        ),
        onTap: onTap,
      );

  _statusColor(int status) {
    switch (status) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.green;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.grey;
      default:
        return Colors.red;
    }
  }
}
