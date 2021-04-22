import 'package:flutter/material.dart';
import 'package:h_order_reception/appRouter.dart';
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
      applyTime: DateTime.now().subtract(Duration(hours: 3)),
      roomNumber: '1208',
      shopName: '던킨 도넛',
      address: '마곡럭스나인오피스텔 L동',
      menus: [],
    ),
    OrderModel(
      objectId: '2',
      status: 1,
      applyTime: DateTime.now().subtract(Duration(hours: 2)),
      roomNumber: '1208',
      shopName: '고샵',
      address: '마곡럭스나인오피스텔 L동',
      menus: [],
    ),
    OrderModel(
      objectId: '3',
      status: 2,
      applyTime: DateTime.now().subtract(Duration(minutes: 20)),
      roomNumber: '1208',
      shopName: '웨스트도어',
      address: '마곡럭스나인오피스텔 L동',
      menus: [],
    ),
    OrderModel(
      objectId: '4',
      status: 3,
      applyTime: DateTime.now().subtract(Duration(minutes: 10)),
      roomNumber: '1208',
      shopName: '봉보야쥬',
      address: '마곡럭스나인오피스텔 L동',
      menus: [],
    ),
    OrderModel(
      objectId: '5',
      status: 4,
      applyTime: DateTime.now().subtract(Duration(minutes: 8)),
      roomNumber: '1208',
      shopName: '비베러디시',
      address: '마곡럭스나인오피스텔 L동',
      menus: [],
    ),
    OrderModel(
      objectId: '6',
      status: 4,
      applyTime: DateTime.now().subtract(Duration(minutes: 2)),
      roomNumber: '1208',
      shopName: '맛집',
      address: '마곡럭스나인오피스텔 L동',
      menus: [],
    ),
  ];

  List<MenuModel> menus = [
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
              address: e.address,
              menus: menus,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
            padding: EdgeInsets.zero,
            children:
                List.generate(list.length, (index) => _item(list[index]))));
  }

  _item(OrderModel item) => DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2,
        child: InkWell(
          onTap: () {
            AppRouter.toOrderPage(item.objectId);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            height: MediaQuery.of(context).size.height * .18,
            decoration: BoxDecoration(
                border: Border(
              bottom:
                  BorderSide(color: CustomColors.tableInnerBorder, width: 1),
            )),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      _itemTime(item),
                      _itemInfo(item),
                      _itemButtons(item.objectId),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 30,
                  child: Text(
                    '${DateFormat("yy/MM/dd").format(item.applyTime)}',
                    style: TextStyle(
                        fontSize: 15, color: CustomColors.subTextBlack),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  _itemTime(OrderModel item) => Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text(
                '${DateFormat("hh:mm").format(item.applyTime)}',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              FractionallySizedBox(
                widthFactor: .6,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _statusColor(item.status),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    _statusText(item.status),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
          alignment: Alignment.topLeft,
        ),
      );

  _itemInfo(OrderModel item) => Expanded(
        flex: 4,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText2.copyWith(height: 1.5),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('[주소] ${item.address} ${item.roomNumber}호'),
                Text(
                  '[메뉴${item.menus.length}개] ${NumberFormat().format(getAmount(item.menus))}원',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(getMenus(item.menus)),
                Text(''),
              ],
            ),
          ),
        ),
      );

  _itemButtons(String orderId) => Expanded(
        flex: 4,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 30),
                child: _itemButton(
                  text: '거절',
                  background: CustomColors.tableInnerBorder,
                  onTap: () {
                    list = list
                        .where((element) => element.objectId != orderId)
                        .toList();
                    setState(() {});
                  },
                ),
              ),
              _itemButton(
                text: '완료',
                background: CustomColors.selectedItemColor,
                onTap: () {
                  list = list
                      .where((element) => element.objectId != orderId)
                      .toList();
                  setState(() {});
                },
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

  Color _statusColor(int status) {
    switch (status) {
      case 0:
        return CustomColors.waitAcceptColor;
      case 1:
        return CustomColors.itemReadyColor;
      case 2:
        return CustomColors.deleveryReadColor;
      case 3:
        return CustomColors.deleveringColor;
      case 4:
        return CustomColors.doneColor;
      default:
        return CustomColors.waitAcceptColor;
    }
  }

  String _statusText(int status) {
    switch (status) {
      case 0:
        return '수락 대기';
      case 1:
        return '상품 준비';
      case 2:
        return '배달 준비 중';
      case 3:
        return '배달 중';
      case 4:
        return '완료';
      default:
        return '수락 대기';
    }
  }

  int getAmount(List<MenuModel> menus) {
    return menus
        .map((e) => e.price * e.count)
        .reduce((value, element) => value + element);
  }

  String getMenus(List<MenuModel> menus) {
    return menus
        .map((e) => e.name + ' ${e.count}개 ')
        .reduce((value, element) => value + element);
  }
}
