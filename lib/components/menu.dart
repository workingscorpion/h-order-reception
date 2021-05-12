import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/baseServiceModel.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/store/historyStore.dart';

class Menu extends StatelessWidget {
  final HistoryModel history;
  final Map data;

  BaseServiceModel get snapShotData {
    return HistoryStore.instance.snapShotDataMap[history.serviceObjectId];
  }

  Menu({
    this.history,
  }) : data = jsonDecode(history.data);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 17,
        color: CustomColors.aBlack,
      ),
      child: Container(
        child: ListView(
          children: [
            ...data.entries.where((e) => e.value != 'null').map((e) => _item(
                  key: e.key,
                  value: e.value,
                )),
          ],
        ),
      ),
    );
  }

  _item({
    String key,
    String value,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                snapShotData.name,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              // child: Text('${menu[index].count}개'),
            ),
            // existPrice == true ? Spacer() : Container(),
            // existPrice == true
            //     ? Text(
            //         '${NumberFormat().format(menu[index].price * menu[index].count)}원')
            //     : Container(),
          ],
        ),
      );
}
