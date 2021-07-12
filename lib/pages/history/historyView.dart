import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/components/spin.dart';
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
  List<MenuModel> menus = List();

  ScrollController _scrollController;
  DateTime _selectedYearMonth;
  DateTime _selectedValue;

  double _datePickerHeight = 80;
  double _datePickerAspectRatio = 0.75;
  EdgeInsets _datePickerPadding = EdgeInsets.symmetric(vertical: 3);

  List<int> _flex = [1, 2, 2, 2, 1, 1];

  bool open = false;

  int current = 1;
  int pageSize = 20;

  List<int> _selectedFilter = List<int>();

  List<int> _status = [1, 2, 3, 4, 9, -1, -9];

  List<RecordModel> get historyDetailsFromDate =>
      HistoryStore.instance.historyDetailsFromDateMap[
          DateFormat('yyyy-MM-dd').format(_selectedValue)] ??
      List();

  @override
  void initState() {
    super.initState();

    _selectToday();

    _selectedFilter.addAll(_status);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _moveDatePicker();
    });

    _scrollController = ScrollController();
  }

  _load() async {
    await HistoryStore.instance
        .loadFromDate(status: _selectedFilter, date: _selectedValue);
    setState(() {});
  }

  _moveDatePicker() async {
    // _controller.animateToDate(
    //   _selectedValue.subtract(Duration(days: 10)),
    //   duration: Duration(milliseconds: 300),
    //   curve: Curves.easeIn,
    // );

    await _load();
  }

  _selectToday() {
    final now = DateTime.now();
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );
    _selectedYearMonth = today;
    _selectedValue = today;

    _scrollTo(_selectedValue.day - 1);
  }

  _scrollTo(int index) {
    final actualHeight = (_datePickerHeight -
        _datePickerPadding.top -
        _datePickerPadding.bottom -
        2);
    final width = actualHeight * _datePickerAspectRatio;
    final offset =
        width * (index + 0.5) - MediaQuery.of(context).size.width / 2;

    _scrollController.animateTo(offset,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  List<Widget> viewBuild() {
    final children = List<Widget>();
    if (HistoryStore.instance.loading) {
      children.addAll([
        _monthPicker(),
        _datePicker(),
        Expanded(
          child: Center(
            child: Spin(
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ]);
    } else {
      children.addAll([
        _monthPicker(),
        _datePicker(),
        _row(),
        _rows(),
      ]);
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: viewBuild(),
          ),
          _floats(),
        ],
      ),
    );
  }

  _rows() => Observer(
        builder: (context) => Expanded(
          child: historyDetailsFromDate.length > 0
              ? ListView(
                  children: List.generate(
                    historyDetailsFromDate.length,
                    (index) => InkWell(
                      onTap: () => AppRouter.toHistoryPage(
                        historyDetailsFromDate[index].history.index.toString(),
                      ),
                      child: _row(
                        item: historyDetailsFromDate[index].history,
                        index: index,
                      ),
                    ),
                  ),
                )
              : Container(
                  child: SvgPicture.asset(
                    'assets/icons/common/empty.svg',
                    height: 200,
                  ),
                ),
        ),
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
          DateFormat("HH:mm:ss").format(item.createdTime).toString(),
        );

      case 1:
        return Text(
            '${item.boundaryName ?? "-"}/${item.deviceName.split("/")?.first}');

      case 2:
        return Text(item.serviceName ?? '-');

      case 3:
        return Text(item.menuName ?? '-');

      case 4:
        return Text((item.amount ?? 0) != 0
            ? '${NumberFormat().format(item.amount)}원'
            : '-');

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
        return Text('발생시간');

      case 1:
        return Text('건물명/방번호');

      case 2:
        return Text('서비스');

      case 3:
        return Text('메뉴명');

      case 4:
        return Text('가격');

      case 5:
        return Text('상태');

      default:
        return Container();
    }
  }

  _datePicker() => Container(
        padding: _datePickerPadding,
        height: _datePickerHeight,
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
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          children: [
            ...List.generate(
              DateTime(_selectedYearMonth.year, _selectedYearMonth.month + 1, 0)
                  .day,
              (index) {
                final current = DateTime(_selectedYearMonth.year,
                    _selectedYearMonth.month, index + 1);
                final selected = current == _selectedValue;
                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);
                final isToday = current == today;

                return Material(
                  borderRadius: BorderRadius.circular(8),
                  color: selected
                      ? CustomColors.doneColor.withOpacity(0.4)
                      : Colors.white,
                  child: InkWell(
                    onTap: () {
                      _selectedValue = current;
                      setState(() {});
                      _scrollTo(index);
                      _load();
                    },
                    child: AspectRatio(
                      aspectRatio: _datePickerAspectRatio,
                      child: Container(
                        alignment: Alignment.center,
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 13,
                            color: isToday
                                ? Colors.blue
                                : current.weekday == DateTime.sunday
                                    ? Colors.red
                                    : Colors.black,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${current.day}',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 7,
                              ),
                              Text(
                                '${DateFormat('E').format(current)}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
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
                  final lastMonthDate = DateTime(
                          _selectedYearMonth.year, _selectedYearMonth.month, 0)
                      .day;
                  _selectedYearMonth = _selectedYearMonth
                      .subtract(Duration(days: lastMonthDate));
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
                        '${DateFormat('yyyy년').format(_selectedYearMonth)}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '${DateFormat('MM월').format(_selectedYearMonth)}',
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
                  final thisMonthDate = DateTime(_selectedYearMonth.year,
                          _selectedYearMonth.month + 1, 0)
                      .day;
                  _selectedYearMonth =
                      _selectedYearMonth.add(Duration(days: thisMonthDate));
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
      children: List.generate(
        _status.length,
        (index) => _floatingMenu(_status[index]),
      ));

  _floatingMenu(int value) => InkWell(
        onTap: () {
          _selectedFilter.contains(value)
              ? _selectedFilter.remove(value)
              : _selectedFilter.add(value);
          setState(() {});
          _load();
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
            CupertinoIcons.color_filter,
            color: Colors.white,
          ),
        ),
      );
}
