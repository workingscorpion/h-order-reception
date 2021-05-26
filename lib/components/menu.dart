import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/historyDetailModel.dart';
import 'package:h_order_reception/model/itemModel.dart';
import 'package:h_order_reception/model/serviceModel.dart';
import 'package:h_order_reception/store/historyStore.dart';
import 'package:intl/intl.dart';

class Menu extends StatefulWidget {
  final int historyIndex;

  Menu({
    this.historyIndex,
  });

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  HistoryDetailModel get historyDetail {
    return HistoryStore.instance.historyDetailMap[widget.historyIndex];
  }

  ServiceModel get snapShotData {
    return HistoryStore
        .instance.snapShotDataMap[historyDetail.snapShot.objectId];
  }

  Map data;
  Map<String, ItemModel> itemMap;

  @override
  void initState() {
    super.initState();

    data = jsonDecode(historyDetail.history.data);
    itemMap = snapShotData.itemMap() ?? Map();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('123'),
    );
    // return DefaultTextStyle(
    //   style: TextStyle(
    //     fontSize: 17,
    //     color: CustomColors.aBlack,
    //   ),
    //   child: Container(
    //     child: Text('123'),
    //     // child: ListView(
    //     //   children: [
    //     //     ...data.entries
    //     //         .where((e) => e.value != 'null')
    //     //         .where((e) => itemMap.containsKey(e.key))
    //     //         .map((e) => _item(
    //     //               item: itemMap[e.key],
    //     //               key: e.key,
    //     //               value: e.value,
    //     //             )),
    //     //   ],
    //     // ),
    //   ),
    // );
  }

  _item({
    ItemModel item,
    String key,
    String value,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Text(
              item.value ?? '',
              overflow: TextOverflow.ellipsis,
            ),
            Container(width: 20),
            Expanded(
              child: _value(
                type: itemMap[key].type ?? -1,
                value: value,
              ),
            ),
            item.price != null
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: _price(
                        price: itemMap[key]?.price,
                        quantity: int.parse(value),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      );

  _value({
    int type,
    String value,
  }) {
    switch (type) {
      case 0:
        return;

      case 2:
        final number = int.parse(value);
        value = '${NumberFormat().format(number)}';
        break;

      case 3:
        value = value.toLowerCase() == 'true' ? '선택' : '미선택';
        break;

      case 100:
        final dateTime = DateTime.parse(value);
        value = '${DateFormat('yyyy-MM-dd HH:mm').format(dateTime)}';
        break;
    }

    return Container(
      child: Text(
        value,
        textAlign: TextAlign.right,
      ),
    );
  }

  _price({
    int price,
    int quantity,
  }) =>
      Container(
        child: Text(
          '${NumberFormat().format(price * quantity)}원',
          textAlign: TextAlign.right,
        ),
      );
}
