import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order_reception/components/menu.dart';
import 'package:h_order_reception/components/timeline.dart';
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
        .map((e) => e.count)
        .reduce((value, element) => value + element);
  }

  Timer timer;

  bool _displayFront;

  @override
  void initState() {
    timer =
        Timer.periodic(Duration(milliseconds: (1000 / 10).floor()), (timer) {
      setState(() {});
    });
    _displayFront = true;
    setState(() {});
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  void flipItem() {
    _displayFront = !_displayFront;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: Container(
        // padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.only(right: 12),
        width: MediaQuery.of(context).size.width * .25,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: _transitionBuilder,
          layoutBuilder: (widget, list) => Stack(children: [widget, ...list]),
          child: _displayFront == true ? _front() : _back(),
          switchInCurve: Curves.easeInBack,
          switchOutCurve: Curves.easeInBack.flipped,
        ),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_displayFront) != widget.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  _front() => Column(
        children: [
          _header(),
          Menu(
            menu: widget.item.menus,
            existPrice: false,
          ),
          _footer(),
        ],
      );

  _back() => Container(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Timeline(
                  histories: widget.item.histories,
                ),
              ),
            ),
            _footer(),
          ],
        ),
      );

  _header() => Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: .5,
              color: CustomColors.doneColor,
            ),
          ),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () => flipItem(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                color: OrderStatusHelper.statusColor[widget.item.status],
                child: Row(
                  children: [
                    Text(
                      '딜리버리',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    Spacer(),
                    Text(
                      OrderStatusHelper.statusText[widget.item.status],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        _displayFront == true
                            ? CupertinoIcons.info_circle
                            : CupertinoIcons.info_circle_fill,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(
                children: [
                  Text(
                    '${widget.item.address}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Text(
                      '${widget.item.roomNumber}호',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _timer() {
    final duration = DateTime.now().difference(widget.item.applyTime);
    final seconds = duration.inSeconds;
    final h = (seconds / 3600).floor();
    final hh = h < 10 ? '0$h' : '$h';

    final m = (seconds % 3600 / 60).floor();
    final mm = m < 10 ? '0$m' : '$m';

    final s = (seconds % 60).floor();
    final ss = s < 10 ? '0$s' : '$s';

    final text = "$hh:$mm:$ss";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      alignment: Alignment.center,
      child: Text(
        '$text',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _summary() => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: CustomColors.doneColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '${DateFormat("yyyy/MM/dd HH:mm").format(widget.item.applyTime)}',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${NumberFormat().format(amount)}원',
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                '${NumberFormat().format(quantity)}개',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      );

  _footer() => Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: CustomColors.doneColor,
            ),
          ),
        ),
        child: Column(
          children: [
            _summary(),
            _timer(),
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
                text: widget.item.status == 0 ? '거절' : '취소',
                background: CustomColors.denyColor,
              ),
              _button(
                onTap: () {},
                text: OrderStatusHelper.statusText[(widget.item.status + 1) %
                    OrderStatusHelper.statusColor.length],
                flex: 2,
              ),
            ],
          ),
        ),
      );

  _button({
    GestureTapCallback onTap,
    String text,
    Color background,
    int flex,
  }) =>
      Expanded(
        flex: flex != null ? flex : 1,
        child: Material(
          color: background != null ? background : Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: CustomColors.doneColor, width: 1),
                ),
              ),
              height: 50,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  color: background != null ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      );
}
