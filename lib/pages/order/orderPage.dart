import 'package:flutter/material.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/menuModel.dart';
import 'package:h_order_reception/model/orderModel.dart';
import 'package:h_order_reception/utils/orderStatusHelper.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  OrderPage({this.orderObjectId});

  final String orderObjectId;

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderModel order;

  List<String> _infoTexts = ['호실 번호', '주문시간', '가게 이름', '상태'];

  @override
  void initState() {
    super.initState();

    _load();
  }

  _load() async {
    // TODO: get Data
    order = OrderModel(
      objectId: '1',
      status: 2,
      applyTime: DateTime.now().subtract(Duration(hours: 3)),
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
          objectId: '1111',
          orderObjectId: '1',
          status: 0,
          updaterName: '준기',
          updatedDate: DateTime.now().subtract(
            Duration(hours: 2),
          ),
        ),
        HistoryModel(
          objectId: '2222',
          orderObjectId: '1',
          status: 1,
          updaterName: '용연',
          updatedDate: DateTime.now().subtract(
            Duration(minutes: 30),
          ),
        ),
        HistoryModel(
          objectId: '3333',
          orderObjectId: '1',
          status: 2,
          updaterName: '현진',
          updatedDate: DateTime.now().subtract(
            Duration(minutes: 10),
          ),
        ),
      ],
    );
  }

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
        color: Colors.grey,
        child: Row(
          children: [
            BackButton(
              onPressed: () => AppRouter.pop(),
            ),
            Spacer(),
            Text('주문현황', style: Theme.of(context).textTheme.bodyText1),
            Spacer(),
          ],
        ),
      );

  _body() => Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: ListView(
            children: [
              _state(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _info(),
                        _history(),
                      ],
                    ),
                  ),
                  Container(
                    width: 20,
                  ),
                  Expanded(
                    child: _menu(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  _itemTitle(String text) => Container(
        margin: EdgeInsets.only(bottom: 20),
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
          )),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  _item({String title, Widget contents}) => Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            _itemTitle(title),
            Container(
              child: contents,
            ),
          ],
        ),
      );

  _state() => _item(
        title: '주문 상태',
        contents: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  OrderStatusHelper.statusText(index),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                decoration: BoxDecoration(
                  color: index == order.status
                      ? OrderStatusHelper.statusColor(index)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      );

  _info() => _item(
        title: '주문 정보',
        contents: Container(
          child: Column(
            children: List.generate(_infoTexts.length,
                (index) => _infoItem(_infoTexts[index], _getContents(index))),
          ),
        ),
      );

  String _getContents(int index) {
    switch (index) {
      case 0:
        return order.roomNumber;
      case 1:
        return DateFormat('MM월 dd일 hh시 mm분').format(order.applyTime);
      case 2:
        // FIXME
        return '주문 서비스';
      case 3:
        return OrderStatusHelper.statusText(order.status);
      default:
        return order.roomNumber;
    }
  }

  _infoItem(String title, String contents) => Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: CustomColors.tableInnerBorder, width: 1),
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(color: CustomColors.tableOuterBorder),
            ),
            Spacer(),
            Text(
              contents,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  _history() => _item(
        title: '진행 내역',
        contents: Container(
          child: Column(
            children: List.generate(
              order.histories.length,
              (index) => _historyItem(index),
            ),
          ),
        ),
      );

  _historyItem(int index) => Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Text(DateFormat('yyyy-MM-dd hh:mm:ss')
                .format(order.histories[index].updatedDate)),
            Spacer(),
            Text(
                '"${order.histories[index].updaterName}"님이 "${OrderStatusHelper.statusText(order.histories[index].status)}"로 진행'),
          ],
        ),
      );

  _menu() => _item(
        title: '메뉴 정보',
        contents: Container(),
      );
}
