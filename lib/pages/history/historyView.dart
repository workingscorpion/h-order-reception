import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/http/client.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/menuModel.dart';
import 'package:h_order_reception/model/recordModel.dart';
import 'package:h_order_reception/store/historyStore.dart';
import 'package:h_order_reception/utils/constants.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<MenuModel> menus;
  List<HistoryModel> _histories = List();
  List<HistoryModel> _selectedHistories = List();

  DateTime _selectedValue;
  DateTime _selectedYear;
  DatePickerController _controller = DatePickerController();

  List<int> _flex = [2, 2, 2, 1, 2, 1];

  bool open = false;

  int current = 1;
  int pageSize = 20;

  List<int> _selectedFilter = List<int>();

  // List<RecordModel> get histories {
  //   return HistoryStore.instance.historyDetails;
  // }

  @override
  void initState() {
    super.initState();

    _selectToday();

    _selectedFilter.addAll([1, 2, 3, 4, 9, -1, 9]);

    // _filterHistories();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _moveDatePicker();
    });
  }

  _load() async {
    final endOfToday = _selectedValue
        .add(Duration(days: 1))
        .subtract(Duration(microseconds: 1));
    final activeStatus =
        _selectedFilter.map((item) => 'filter.status=$item').join('&');
    final res = await Client.create().histories(
      activeStatus,
      'CreatedTime',
      _selectedValue.toString(),
      endOfToday.toString(),
    );
    _histories = res.list.map((e) {
      var menuName = '';
      if (e.data != null) {
        final data = jsonDecode(e.data);
        menuName = jsonDecode(data['cart']).first['name'];
      }

      return HistoryModel(
        index: e.index,
        status: e.status,
        serviceObjectId: e.serviceObjectId,
        userObjectId: e.userObjectId,
        userName: e.userName,
        deviceObjectId: e.deviceObjectId,
        deviceName: e.deviceName,
        data: e.data,
        amount: e.amount,
        quantity: e.quantity,
        createdTime: e.createdTime,
        updatedTime: e.updatedTime,
        menuName: menuName,
      );
    }).toList();

    setState(() {});
  }

  _historySort() {
    if (_selectedHistories.length > 0) {
      _selectedHistories
          .sort((a, b) => a.createdTime.isAfter(b.createdTime) ? -1 : 1);
    }
  }

  _compare(DateTime applyTime) {
    final Duration diff = applyTime.difference(_selectedValue);
    return diff.inHours < 24 && diff.inHours >= 0 ? true : false;
  }

  _moveDatePicker() async {
    _controller.animateToDate(
      _selectedValue.subtract(Duration(days: 10)),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    await _load();
    _filterHistories();

    setState(() {});
  }

  _filterHistories() {
    _selectedHistories = _histories
        // .map((e) => e.history)
        .where((element) => _compare(element.createdTime))
        .where((element) => _selectedFilter.contains(element.status))
        .toList();
    _historySort();
  }

  _selectToday() {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    _selectedYear = today;
    _selectedValue = today;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _monthPicker(),
              _datePicker(),
              _row(),
              _rows(),
            ],
          ),
          _floats(),
        ],
      ),
    );
  }

  _rows() => Expanded(
        child: _selectedHistories.length > 0
            ? ListView(
                children: List.generate(
                  _selectedHistories.length,
                  (_selectedHistoryIndex) => InkWell(
                    onTap: () => AppRouter.toHistoryPage(
                      _selectedHistories[_selectedHistoryIndex]
                          .index
                          .toString(),
                    ),
                    // child: Text('order'),
                    child: _row(
                      item: _selectedHistories[_selectedHistoryIndex],
                      index: _selectedHistoryIndex,
                    ),
                  ),
                ),
              )
            : Container(),
        // child: Observer(
        //   builder: (BuildContext context) {
        //     return ;
        //   },
        // ),
      );

  _row({
    HistoryModel item,
    int index,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(
          vertical: item != null ? 15 : 10,
          horizontal: 26,
        ),
        decoration: item != null
            ? BoxDecoration(
                color: index % 2 == 0 ? Colors.white : CustomColors.evenColor,
              )
            : BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CustomColors.doneColor,
                    width: 1,
                  ),
                ),
              ),
        child: Row(
          children: List.generate(
            _flex.length,
            (index) => Expanded(
              flex: _flex[index],
              child: Container(
                alignment: Alignment.center,
                child: item != null
                    ? DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        child: _rowItem(item, index),
                      )
                    : DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        child: _rowTitle(index),
                      ),
              ),
            ),
          ),
        ),
      );

  Widget _rowItem(HistoryModel item, int index) {
    switch (index) {
      case 0:
        return Text(
          DateFormat("yyyy/MM/dd HH:mm:ss").format(item.createdTime).toString(),
        );

      case 1:
        return Text('건물이름/${item.deviceName}');

      case 2:
        // return Text('메뉴메뉴');
        return Text(item.menuName);

      case 3:
        return Text('${item.quantity}개');

      case 4:
        return Text('${NumberFormat().format(item.amount)}원');

      case 5:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: orderStatus[item.status].color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: 90,
            padding: EdgeInsets.symmetric(vertical: 3),
            alignment: Alignment.center,
            child: Text(
              orderStatus[item.status].name,
              style: TextStyle(
                color: item.status == 4 ? Colors.black : Colors.white,
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Widget _rowTitle(int index) {
    switch (index) {
      case 0:
        return Text('발생일');

      case 1:
        return Text('건물명/방번호');

      case 2:
        return Text('메뉴명');

      case 3:
        return Text('총 개수');

      case 4:
        return Text('가격');

      case 5:
        return Text('상태');

      default:
        return Container();
    }
  }

  _datePicker() => Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: CustomColors.doneColor,
              width: 1,
            ),
            bottom: BorderSide(
              color: CustomColors.doneColor,
              width: 1,
            ),
          ),
        ),
        child: DatePicker(
          DateTime(_selectedYear.year, _selectedYear.month, 1),
          daysCount:
              DateTime(_selectedYear.year, _selectedYear.month + 1, 0).day,
          initialSelectedDate: _selectedValue,
          selectionColor: CustomColors.doneColor.withOpacity(.5),
          selectedTextColor: CustomColors.aBlack,
          monthTextStyle: TextStyle(fontSize: 0, color: Colors.transparent),
          controller: _controller,
          locale: 'ko',
          height: 95,
          dayTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          onDateChange: (DateTime date) {
            _selectedValue = DateTime(_selectedYear.year, date.month, date.day);
            setState(() {});
            _moveDatePicker();
          },
        ),
      );

  _monthPicker() => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        alignment: Alignment.centerLeft,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  final lastMonthDate =
                      DateTime(_selectedYear.year, _selectedYear.month, 0).day;
                  _selectedYear =
                      _selectedYear.subtract(Duration(days: lastMonthDate));
                  setState(() {});
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 4, right: 5, top: 9, bottom: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: CustomColors.doneColor),
                  ),
                  child: Icon(
                    CupertinoIcons.chevron_left,
                    size: 18,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Text(
                        '${DateFormat('yyyy년').format(_selectedYear)}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '${DateFormat('MM월').format(_selectedYear)}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  final thisMonthDate =
                      DateTime(_selectedYear.year, _selectedYear.month + 1, 0)
                          .day;
                  _selectedYear =
                      _selectedYear.add(Duration(days: thisMonthDate));
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 5, right: 4, top: 9, bottom: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: CustomColors.doneColor),
                  ),
                  child: Icon(
                    CupertinoIcons.chevron_right,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  _floats() => Positioned(
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
      children: List.generate(5, (index) => _floatingMenu(index)));

  _floatingMenu(int value) => InkWell(
        onTap: () {
          _selectedFilter.contains(value)
              ? _selectedFilter.remove(value)
              : _selectedFilter.add(value);
          _filterHistories();
          setState(() {});
        },
        child: Container(
          width: 120,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _selectedFilter.contains(value)
                ? orderStatus[value].color
                : CustomColors.tableInnerBorder,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            orderStatus[value].name,
            style: TextStyle(
              fontSize: 15,
              color: value != 4 ? Colors.white : Colors.black,
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
            CupertinoIcons.color_filter,
            color: Colors.white,
          ),
        ),
      );
}
