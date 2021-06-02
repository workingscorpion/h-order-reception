import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/recordModel.dart';
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
  RecordModel get historyDetail {
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

    data = (historyDetail?.history?.data?.isNotEmpty ?? false)
        ? jsonDecode(historyDetail.history.data)
        : Map();
    itemMap = snapShotData?.itemMap() ?? Map();
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    switch (snapShotData.type) {
      case ServiceType.Call:
        {
          final widgets = data.entries
              .where((e) => e.value != 'null')
              .where((e) => itemMap.containsKey(e.key))
              .map((e) => _item(
                    item: itemMap[e.key],
                    value: e.value,
                  ));

          children..addAll(widgets);
        }
        break;

      case ServiceType.Shop:
        {
          if ((data?.containsKey('cart') ?? false) == false) {
            break;
          }

          final cart = jsonDecode(data['cart']) as List;
          final widgets = cart.map((e) {
            final productObjectId = e['product']['objectId'];
            final product = itemMap[productObjectId];

            final quantity = e['quantity'];
            final optionQuantity = e['optionQuantity'] as Map;

            return Column(
              children: [
                _item(
                  item: product,
                  value: quantity.toString(),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 24),
                    child: Column(
                      children: [
                        ...optionQuantity.entries.where((e) => e.value > 0).map(
                              (e) => _item(
                                item: itemMap[e.key],
                                value: e.value.toString(),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList();

          children..addAll(widgets);
        }
        break;
    }

    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 17,
        color: CustomColors.aBlack,
      ),
      child: Container(
        child: ListView(
          children: [
            ...children,
          ],
        ),
      ),
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

  Widget _item({
    ItemModel item,
    String value,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.value ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(width: 20),
            Expanded(
              child: value?.isNotEmpty ?? false
                  ? _value(
                      type: item.type ?? -1,
                      value: value,
                    )
                  : Container(),
            ),
            item.price != null
                ? Expanded(
                    child: _price(
                      price: item.price,
                      quantity: 1,
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
      case ItemType.Group:
        return;

      case ItemType.Number:
        final number = int.parse(value);
        value = '${NumberFormat().format(number)}';
        break;

      case ItemType.Boolean:
        value = value.toLowerCase() == 'true' ? '선택' : '미선택';
        break;

      case ItemType.DateTime:
        final dateTime = DateTime.parse(value);
        value = '${DateFormat('yyyy-MM-dd HH:mm').format(dateTime)}';
        break;

      case ItemType.Product:
      case ItemType.ProductOption:
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

class ServiceType {
  static const Call = 2;
  static const Shop = 3;
}

class ItemType {
  static const Position = -1;
  static const Group = 0;

  static const Text = 1;
  static const Number = 2;
  static const Boolean = 3;
  static const Input = 4;

  static const DateTime = 100;
  static const Date = 101;
  static const Time = 102;

  static const Url = 200;
  static const Image = 201;
  static const File = 202;
  static const WebView = 203;

  static const Product = 300;
  static const ProductOption = 301;
}
