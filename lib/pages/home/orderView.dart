import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/utils/orderStatusHelper.dart';

class OrderView extends StatefulWidget {
  OrderView() : super();

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  bool open = false;

  List<HistoryModel> histories;
  List<int> _selectedFilter = List<int>();

  @override
  void initState() {
    super.initState();

    histories = [
      HistoryModel(
        objectId: '55555',
        orderObjectId: '1',
        status: 4,
        updatedDate: DateTime.now().subtract(Duration(minutes: 5)),
        updaterName: '준기',
      ),
      HistoryModel(
        objectId: '44444',
        orderObjectId: '1',
        status: 3,
        updatedDate: DateTime.now().subtract(Duration(minutes: 10)),
        updaterName: '준기',
      ),
      HistoryModel(
        objectId: '33333',
        orderObjectId: '1',
        status: 2,
        updatedDate: DateTime.now().subtract(Duration(minutes: 30)),
        updaterName: '준기',
      ),
      HistoryModel(
        objectId: '22222',
        orderObjectId: '1',
        status: 1,
        updatedDate: DateTime.now().subtract(Duration(hours: 1)),
        updaterName: '준기',
      ),
      HistoryModel(
        objectId: '11111',
        orderObjectId: '1',
        status: 0,
        updatedDate: DateTime.now().subtract(Duration(hours: 2)),
        updaterName: '준기',
      ),
    ];

    _selectedFilter.addAll([0, 1, 2, 3]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(bottom: 12, top: 12, left: 12, right: 100),
            children: [
              // ...orders
              //     .where((element) => _selectedFilter.contains(element.status))
              //     .map<Widget>((item) => OrderItem(item: item)),
            ],
          ),
          _float(),
        ],
      ),
    );
  }

  _float() => Positioned(
        bottom: 20,
        right: 20,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: open == true
                ? [
                    _floatingMenus(),
                    _floating(),
                  ]
                : [
                    _floating(),
                  ],
          ),
        ),
      );

  _floatingMenus() => Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(4, (index) => _floatingMenu(index)));

  _floatingMenu(int index) => InkWell(
        onTap: () {
          _selectedFilter.contains(index)
              ? _selectedFilter.remove(index)
              : _selectedFilter.add(index);
          setState(() {});
        },
        child: Container(
          width: 120,
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: _selectedFilter.contains(index)
                ? OrderStatusHelper.statusColor[index]
                : CustomColors.tableInnerBorder,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            OrderStatusHelper.statusText[index],
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      );

  _floating() => InkWell(
        onTap: () {
          open = !open;
          setState(() {});
        },
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColors.tableInnerBorder,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ]),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
}
