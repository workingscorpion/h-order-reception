import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/menuModel.dart';
import 'package:h_order_reception/model/orderModel.dart';
import 'package:h_order_reception/utils/orderStatusHelper.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  OrderItem({this.item});

  final OrderModel item;

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: Container(
        width: MediaQuery.of(context).size.width * .25,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: CustomColors.tableInnerBorder, width: 1),
          ),
        ),
        child: Column(
          children: [
            _itemHeader(),
            _menu(),
            Spacer(),
            _itemFooter(),
          ],
        ),
      ),
    );
  }

  _itemHeader() => Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: CustomColors.tableInnerBorder,
            width: 1,
          ),
        )),
        child: Row(
          children: [
            Column(
              children: [
                Text('딜리버리'),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: OrderStatusHelper.statusColor(widget.item.status),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    OrderStatusHelper.statusText(widget.item.status),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${widget.item.address}'),
                Text('${widget.item.roomNumber}호'),
              ],
            ),
          ],
        ),
      );

  _menu() => Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text('123'),
      );

  _itemFooter() => Container(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              child: Row(
                children: [
                  Text(
                    '${DateFormat("yy/MM/dd").format(widget.item.applyTime)}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Spacer(),
                  Text(
                    '${NumberFormat().format(getAmount())}원',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            _itemButtons(),
          ],
        ),
      );

  _itemButtons() => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // margin: EdgeInsets.only(right: 30),
              child: _itemButton(
                text: '거절',
                background: CustomColors.tableInnerBorder,
                onTap: () {
                  // list = list
                  //     .where((element) => element.objectId != orderId)
                  //     .toList();
                  // setState(() {});
                },
              ),
            ),
            _itemButton(
              text: '완료',
              background: CustomColors.selectedItemColor,
              onTap: () {
                // list = list
                //     .where((element) => element.objectId != orderId)
                //     .toList();
                // setState(() {});
              },
            ),
          ],
        ),
      );

  _itemButton({String text, Color background, Function onTap}) =>
      InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(5),
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
        onTap: onTap,
      );

  int getAmount() {
    return [...widget.item.menus]
        .map((e) => e.price * e.count)
        .reduce((value, element) => value + element);
  }

  String getMenus() {
    return [...widget.item.menus]
        .map((e) => e.name + ' ${e.count}개 ')
        .reduce((value, element) => value + element);
  }
}
