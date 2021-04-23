import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/orderModel.dart';
import 'package:h_order_reception/utils/orderStatusHelper.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final OrderModel item;

  OrderItem({
    this.item,
  });

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  get amount {
    return [...widget.item.menus]
        .map((e) => e.price * e.count)
        .reduce((value, element) => value + element);
  }

  get quantity {
    return [...widget.item.menus]
        .map((e) => e.name + ' ${e.count}개 ')
        .reduce((value, element) => value + element);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: Container(
        margin: EdgeInsets.only(right: 12),
        width: MediaQuery.of(context).size.width * .25,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            _header(),
            _menu(),
            _footer(),
          ],
        ),
      ),
    );
  }

  _header() => Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: OrderStatusHelper.statusColor[widget.item.status],
              child: Row(
                children: [
                  Text(
                    OrderStatusHelper.statusText[widget.item.status],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${widget.item.address}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Text(
                    '딜리버리',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${widget.item.roomNumber}호',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _menu() => Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: .5,
                color: Colors.black26,
              ),
              bottom: BorderSide(
                width: .5,
                color: Colors.black26,
              ),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.all(10),
            children: List.generate(
              20,
              (index) => Container(
                child: Row(
                  children: [
                    Text('메뉴리스트'),
                    Spacer(),
                    Text('1개'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  _row({
    List data,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border(
          bottom: data != null
              ? BorderSide.none
              : BorderSide(color: CustomColors.tableInnerBorder, width: 1),
        )),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(data != null ? data[0] : '메뉴'),
            ),
            Expanded(
              flex: 1,
              child: Text(data != null ? data[1] : '개수'),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(data != null ? data[2] : '가격'),
              ),
            ),
          ],
        ),
      );

  _summary() => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Text(
              '${DateFormat("yyyy/MM/dd HH:mm").format(widget.item.applyTime)}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Spacer(),
            Text(
              '${NumberFormat().format(amount)}원',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      );

  _footer() => Container(
        child: Column(
          children: [
            _summary(),
            _buttons(),
          ],
        ),
      );

  _buttons() => IntrinsicHeight(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _button(
                onTap: () {},
                text: '거절',
                background: CustomColors.tableInnerBorder,
              ),
              _button(
                onTap: () {},
                text: OrderStatusHelper.statusText[(widget.item.status + 1) %
                    OrderStatusHelper.statusColor.length],
                background: OrderStatusHelper.statusColor[
                    (widget.item.status + 1) %
                        OrderStatusHelper.statusColor.length],
              ),
            ],
          ),
        ),
      );

  _button({
    GestureTapCallback onTap,
    String text,
    Color background,
  }) =>
      Expanded(
        child: Material(
          color: background,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 40,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
}
