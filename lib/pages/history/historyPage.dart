import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/components/menu.dart';
import 'package:h_order_reception/components/timeline.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/menuModel.dart';
import 'package:h_order_reception/model/orderModel.dart';
import 'package:h_order_reception/utils/orderStatusHelper.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({this.orderObjectId});

  final String orderObjectId;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  OrderModel order;

  final List<String> _infoTitles = ['건물정보', '방번호', '발생시간', '서비스명'];

  List<String> _infoData;

  get amount {
    return [...order.menus]
        .map((e) => e.price * e.count)
        .reduce((value, element) => value + element);
  }

  @override
  void initState() {
    order = OrderModel(
      objectId: '1',
      status: 0,
      applyTime: DateTime.now().subtract(Duration(days: 2)),
      roomNumber: '1208',
      shopName: '던킨 도넛',
      address: '마곡럭스나인오피스텔 L동',
      menus: [
        MenuModel(
          boundaryId: '11',
          count: 1,
          name: '아메리카노',
          objectId: '111',
          price: 1000,
        ),
        MenuModel(
          boundaryId: '11',
          count: 2,
          name: '에스프레소',
          objectId: '222',
          price: 3500,
        ),
      ],
      histories: [
        HistoryModel(
          objectId: '55555',
          orderObjectId: '1',
          status: 4,
          updatedDate: DateTime.now().subtract(Duration(minutes: 5)),
          updaterName: '준기',
        ),
        HistoryModel(
          objectId: '44444',
          orderObjectId: '1',
          status: 3,
          updatedDate: DateTime.now().subtract(Duration(minutes: 10)),
          updaterName: '준기',
        ),
        HistoryModel(
          objectId: '33333',
          orderObjectId: '1',
          status: 2,
          updatedDate: DateTime.now().subtract(Duration(minutes: 30)),
          updaterName: '준기',
        ),
        HistoryModel(
          objectId: '22222',
          orderObjectId: '1',
          status: 1,
          updatedDate: DateTime.now().subtract(Duration(hours: 1)),
          updaterName: '준기',
        ),
        HistoryModel(
          objectId: '11111',
          orderObjectId: '1',
          status: 0,
          updatedDate: DateTime.now().subtract(Duration(hours: 2)),
          updaterName: '준기',
        ),
      ],
    );

    _infoData = [
      order.address,
      order.roomNumber,
      DateFormat().format(order.applyTime),
      order.shopName,
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _header(),
              _statuses(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _info(),
                      Container(width: 20),
                      _menu(),
                      Container(width: 20),
                      _history(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _info() => Expanded(
        flex: 3,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: List.generate(4, (index) => _infoItem(index)),
          ),
        ),
      );

  _infoItem(int index) => Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Text(_infoTitles[index]),
            Spacer(),
            Text(_infoData[index]),
          ],
        ),
      );

  _menu() => Expanded(
        flex: 4,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Menu(
                menu: order.menus,
                existPrice: true,
              ),
              _amount(),
            ],
          ),
        ),
      );

  _amount() => Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 20,
            color: CustomColors.aBlack,
          ),
          child: Row(
            children: [
              Text('총'),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Text('${order.menus.length}개'),
              ),
              Text('${NumberFormat().format(amount)}원'),
            ],
          ),
        ),
      );

  _history() => Expanded(
        flex: 4,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Timeline(histories: order.histories),
        ),
      );

  _header() => Container(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(CupertinoIcons.chevron_left),
              onPressed: () => AppRouter.pop(),
            ),
            Spacer(),
            Text(
              '주문현황',
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
          ],
        ),
      );

  _statuses() => Container(
        child: Row(
          children: List.generate(5, (index) => _status(index)),
        ),
      );

  _status(int index) => Expanded(
        child: InkWell(
          onTap: () {
            order.status = index;
            setState(() {});
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: index == order.status
                  ? OrderStatusHelper.statusColor[index]
                  : CustomColors.tableInnerBorder,
            ),
            alignment: Alignment.center,
            child: Text(
              OrderStatusHelper.statusText[index],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
}
