import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/orderModel.dart';
import 'package:h_order_reception/utils/orderStatusHelper.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<OrderModel> _histories;
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue;
  DateTime _selectedYear;
  List<int> _flex = [2, 2, 2, 1, 2, 1];

  @override
  void initState() {
    // TODO: implement initState
    _selectedValue = DateTime.now();
    _selectedYear = DateTime(DateTime.now().year, 1, 1);
    _histories = [];
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _moveDatePicker();
    });
  }

  _moveDatePicker() {
    _controller.animateToDate(
      _selectedValue.subtract(Duration(days: 10)),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _yearPicker(context),
          _datePicker(),
          _rows(),
        ],
      ),
    );
  }

  _rows() => Expanded(
        child: ListView(
          children: List.generate(
              _histories.length, (index) => _row(item: _histories[index])),
        ),
      );

  _row({
    OrderModel item,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 26,
        ),
        child: Row(
          children: List.generate(
              _flex.length,
              (index) => Expanded(
                    flex: _flex[index],
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: item != null
                          ? _rowItem(item, index)
                          : _rowTitle(index),
                    ),
                  )),
        ),
      );

  Widget _rowItem(OrderModel item, int index) {
    switch (index) {
      case 0:
        return Text(DateFormat("yyyy/MM/dd hh:mm:ss")
            .format(item.applyTime)
            .toString());
      case 1:
        return Column(
          children: [
            Text(
              item.address,
              style: TextStyle(fontSize: 16),
            ),
            Text(item.roomNumber)
          ],
        );
      case 2:
        return Text(item.menus.first.name);
      case 3:
        return Text('총 ${item.menus.length}');
      case 4:
        return Text('총 ${NumberFormat().format(item.menus.first.price)}');
      case 5:
        return Text(
          OrderStatusHelper.statusText[item.status],
          style: TextStyle(
            color: OrderStatusHelper.statusColor[item.status],
          ),
        );
    }
  }

  Widget _rowTitle(int index) {
    switch (index) {
      case 0:
        return Text('발생일');
      case 1:
        return Column(
          children: [
            Text(
              '건물명',
              style: TextStyle(fontSize: 16),
            ),
            Text('방번호')
          ],
        );
      case 2:
        return Text('메뉴명');
      case 3:
        return Text('총 개수');
      case 4:
        return Text('가격');
      case 5:
        return Text('상태');
    }
  }

  _datePicker() => Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CustomColors.tableOuterBorder,
              width: 1,
            ),
          ),
        ),
        child: DatePicker(
          DateTime(_selectedYear.year, 1, 1),
          // daysCount: 365,
          initialSelectedDate: _selectedValue,

          selectionColor: CustomColors.tableInnerBorder.withOpacity(.7),
          selectedTextColor: CustomColors.aBlack,
          controller: _controller,
          locale: 'ko',
          height: 90,
          dayTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          onDateChange: (date) {
            _selectedValue = date;
            setState(() {});
            _moveDatePicker();
          },
        ),
      );

  _yearPicker(BuildContext context) => Container(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => Container(
              child: Text('cndsjkllfasd'),
            ),
          ),
          child: Text(_selectedYear.year.toString()),
        ),
      );
}
