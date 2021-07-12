import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:h_order_reception/components/clock.dart';
import 'package:h_order_reception/components/menu.dart';
import 'package:h_order_reception/components/refuseDialog.dart';
import 'package:h_order_reception/components/timeline.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/recordModel.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/serviceModel.dart';
import 'package:h_order_reception/store/historyStore.dart';
import 'package:h_order_reception/utils/constants.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final int historyIndex;

  OrderItem({
    this.historyIndex,
  }) : super(key: Key('$historyIndex'));

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  RecordModel get historyDetail {
    return HistoryStore.instance.historyDetailMap[widget.historyIndex];
  }

  HistoryModel get history {
    return historyDetail.history;
  }

  ServiceModel get snapShotData {
    return HistoryStore
        .instance.snapShotDataMap[historyDetail.snapShot.objectId];
  }

  bool front;

  @override
  void initState() {
    super.initState();

    front = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: Container(
        margin: EdgeInsets.only(right: 12),
        width: MediaQuery.of(context).size.width * .25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: CustomColors.doneColor,
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Observer(
          builder: (context) =>
              Column(
                children: [
                  _header(),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(),
                      clipBehavior: Clip.antiAlias,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        transitionBuilder: (widget, animation) {
                          final rotateAnimation =
                              Tween(begin: pi, end: 0.0).animate(animation);

                          return AnimatedBuilder(
                            animation: rotateAnimation,
                            child: widget,
                            builder: (context, widget) {
                              final isUnder = (ValueKey(front) != widget.key);
                              final tilt =
                                  ((animation.value - 0.5).abs() - 0.5) *
                                      0.003 *
                                      (isUnder ? -1.0 : 1.0);
                              final value = isUnder
                                  ? min(rotateAnimation.value, pi / 2)
                                  : rotateAnimation.value;

                              return Transform(
                                transform: (Matrix4.rotationY(value)
                                  ..setEntry(3, 0, tilt)),
                                alignment: Alignment.center,
                                child: widget,
                              );
                            },
                          );
                        },
                        switchInCurve: Curves.ease,
                        switchOutCurve: Curves.ease.flipped,
                        layoutBuilder: (widget, list) => Stack(
                          children: [
                            widget,
                            ...list,
                          ],
                        ),
                        child: front == true
                            ? Menu(historyIndex: widget.historyIndex)
                            : Timeline(historyIndex: widget.historyIndex),
                      ),
                    ),
                  ),
                  _footer(),
                ],
              ) ??
              Container(),
        ),
      ),
    );
  }

  _header() => Container(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                front = !front;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                color: orderStatus[history.status].color,
                child: Row(
                  children: [
                    Text(
                      snapShotData.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    Spacer(),
                    Text(
                      orderStatus[history.status].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        front == true
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
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          history.userName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Text(
                            history.deviceName ?? '미입력',
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
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: CustomColors.doneColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  _summary() => Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: CustomColors.doneColor,
            ),
            bottom: BorderSide(
              width: 1,
              color: CustomColors.doneColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              child: Text(
                '${DateFormat("yyyy/MM/dd HH:mm").format(history.createdTime)}',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Spacer(),
            history.amount != null
                ? Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      '${NumberFormat().format(history.amount)}원',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  )
                : Container(),
            history.quantity != null
                ? Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      '${NumberFormat().format(history.quantity)}개',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      );

  _footer() => Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  _summary(),
                  Clock(dateTime: history.createdTime),
                ],
              ),
            ),
            _buttons(),
          ],
        ),
      );

  _buttons() {
    final keys = orderStatus.keys.toList();
    var nextIndex;
    var nextStatus;
    if (history.serviceType == 3) {
      nextIndex = (keys.indexOf(history.status) + 1) % keys.length;
      nextStatus = keys[nextIndex];
    } else {
      final callKeys = [-1, -9, 1, 2, 9];
      nextIndex = (callKeys.indexOf(history.status) + 1) % callKeys.length;
      nextStatus = callKeys[nextIndex];
    }

    return IntrinsicHeight(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _button(
              onTap: () async {
                final result = await showDialog(
                  context: context,
                  child: RefuseDialog(
                    historyIndex: widget.historyIndex,
                    status: history.status,
                  ),
                );

                if (result == null) {
                  return;
                }

                final message = result as String;

                HistoryStore.instance.setStatus(
                  index: widget.historyIndex,
                  status: -9,
                  message: message,
                );
              },
              text: history.status == 1 ? '거절' : '취소',
              background: CustomColors.denyColor,
              color: Colors.white,
            ),
            _button(
              onTap: () async {
                HistoryStore.instance.setStatus(
                  index: history.index,
                  status: nextStatus,
                );
              },
              text: orderStatus[nextStatus].name,
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  _button({
    GestureTapCallback onTap,
    String text,
    Color background,
    Color color,
    int flex,
  }) =>
      Expanded(
        flex: flex != null ? flex : 1,
        child: Material(
          color: background != null ? background : Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: background == CustomColors.denyColor
                  ? BoxDecoration()
                  : BoxDecoration(
                      border: Border(
                        top:
                            BorderSide(color: CustomColors.doneColor, width: 1),
                      ),
                    ),
              height: 50,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
}
