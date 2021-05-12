import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:h_order_reception/components/orderItem.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/store/historyStore.dart';
import 'package:h_order_reception/utils/constants.dart';

class OrderView extends StatefulWidget {
  OrderView() : super();

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  bool open = false;

  List<HistoryModel> get histories {
    return HistoryStore.instance.histories;
  }

  List<int> _selectedFilter;

  @override
  void initState() {
    super.initState();

    _selectedFilter = List();

    load();
  }

  load() async {
    await HistoryStore.instance.load();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Observer(
            builder: (context) => ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding:
                  EdgeInsets.only(bottom: 12, top: 12, left: 12, right: 100),
              children: [
                ...histories
                    .where((item) =>
                        (_selectedFilter?.isEmpty ?? true) ||
                        _selectedFilter.contains(item.status))
                    .map((item) => OrderItem(historyIndex: item.index)),
              ],
            ),
          ),
          _floats(),
        ],
      ),
    );
  }

  _floats() => Positioned(
        bottom: 20,
        right: 20,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ...open == true ? [_floatingButtonMenus()] : [],
              _floatingButton(),
            ],
          ),
        ),
      );

  _floatingButtonMenus() => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...orderStatus.keys.map((value) => _floatingButtonMenu(value)),
        ],
      );

  _floatingButtonMenu(int value) => Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Material(
          color: _selectedFilter.contains(value)
              ? orderStatus[value].color
              : CustomColors.tableInnerBorder,
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              _selectedFilter.contains(value)
                  ? _selectedFilter.remove(value)
                  : _selectedFilter.add(value);
              setState(() {});
            },
            child: Container(
              width: 120,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                orderStatus[value].name,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );

  _floatingButton() => Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(35),
        color: CustomColors.tableInnerBorder,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            open = !open;
            setState(() {});
          },
          child: Container(
            height: 70,
            width: 70,
            child: Icon(
              CupertinoIcons.color_filter,
              color: Colors.white,
            ),
          ),
        ),
      );
}
