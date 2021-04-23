import 'package:flutter/material.dart';
import 'package:h_order_reception/components/orderItem.dart';
import 'package:h_order_reception/model/menuModel.dart';
import 'package:h_order_reception/model/orderModel.dart';

class OrderView extends StatefulWidget {
  OrderView() : super();

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  List<MenuModel> menus;

  List<OrderModel> orders;

  @override
  void initState() {
    super.initState();

    menus = [
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
    ];

    orders = [
      OrderModel(
        objectId: '1',
        status: 0,
        applyTime: DateTime.now().subtract(Duration(hours: 3)),
        roomNumber: '1208',
        shopName: '던킨 도넛',
        address: '마곡럭스나인오피스텔 L동',
        menus: [...menus],
      ),
      OrderModel(
        objectId: '2',
        status: 1,
        applyTime: DateTime.now().subtract(Duration(hours: 2)),
        roomNumber: '1208',
        shopName: '고샵',
        address: '마곡럭스나인오피스텔 L동',
        menus: [...menus],
      ),
      OrderModel(
        objectId: '3',
        status: 2,
        applyTime: DateTime.now().subtract(Duration(minutes: 20)),
        roomNumber: '1208',
        shopName: '웨스트도어',
        address: '마곡럭스나인오피스텔 L동',
        menus: [...menus],
      ),
      OrderModel(
        objectId: '4',
        status: 3,
        applyTime: DateTime.now().subtract(Duration(minutes: 10)),
        roomNumber: '1208',
        shopName: '봉보야쥬',
        address: '마곡럭스나인오피스텔 L동',
        menus: [...menus],
      ),
      OrderModel(
        objectId: '5',
        status: 4,
        applyTime: DateTime.now().subtract(Duration(minutes: 8)),
        roomNumber: '1208',
        shopName: '비베러디시',
        address: '마곡럭스나인오피스텔 L동',
        menus: [...menus],
      ),
      OrderModel(
        objectId: '6',
        status: 4,
        applyTime: DateTime.now().subtract(Duration(minutes: 2)),
        roomNumber: '1208',
        shopName: '맛집',
        address: '마곡럭스나인오피스텔 L동',
        menus: [...menus],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(12),
        children: [
          ...orders.map((item) => OrderItem(item: item)),
        ],
      ),
    );
  }
}
