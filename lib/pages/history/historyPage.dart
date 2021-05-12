import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/menuModel.dart';
import 'package:h_order_reception/model/orderModel.dart';
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
      histories: [],
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
      backgroundColor: Colors.white,
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
                      _history(),
                      Container(width: 15),
                      _menu(),
                      Container(width: 15),
                      _info(),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: CustomColors.doneColor, width: 1),
                ),
                child: Column(
                  children: List.generate(4, (index) => _infoItem(index)),
                ),
              ),
            ),
            Container(height: 10),
            Container(
              height: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: CustomColors.denyColor,
              ),
              alignment: Alignment.center,
              child: Text(
                order.status == 0 ? '거절' : '취소',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ],
        ),
      );

  _infoItem(int index) => Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Text(
              _infoTitles[index],
              style: TextStyle(fontSize: 17),
            ),
            Spacer(),
            Text(
              _infoData[index],
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  _menu() => Expanded(
        flex: 4,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CustomColors.doneColor, width: 1),
          ),
          child: Column(
            children: [
              // Menu(
              //   menu: order.menus,
              //   existPrice: true,
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: _amount(),
              ),
            ],
          ),
        ),
      );

  _amount() => Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: CustomColors.doneColor, width: 1),
          ),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 22,
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
            border: Border.all(color: CustomColors.doneColor, width: 1),
          ),
          // child: Timeline(histories: order.histories),
        ),
      );

  _header() => Container(
        height: 50,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => AppRouter.pop(),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        EdgeInsets.only(left: 4, right: 5, top: 9, bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: CustomColors.doneColor),
                    ),
                    child: Icon(
                      CupertinoIcons.chevron_left,
                      size: 18,
                    ),
                  ),
                  Text(
                    '주문현황',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      );

  _statuses() => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
            margin: index != 4 ? EdgeInsets.only(right: 15) : EdgeInsets.zero,
            decoration: BoxDecoration(
              // color: index == order.status
              //     ? OrderStatusHelper.statusColor[index]
              //     : CustomColors.evenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            // child: Text(
            //   OrderStatusHelper.statusText[index],
            //   style: TextStyle(
            //     color: index == order.status && order.status != 4
            //         ? Colors.white
            //         : Colors.black,
            //     fontSize: 17,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ),
        ),
      );
}
