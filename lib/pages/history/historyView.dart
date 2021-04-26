import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/menuModel.dart';
import 'package:h_order_reception/model/orderModel.dart';
import 'package:h_order_reception/utils/orderStatusHelper.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  HistoryView({Key key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<MenuModel> menus;
  List<HistoryModel> histories;
  List<OrderModel> _histories;
  List<OrderModel> _selectedHistories;

  DateTime _selectedValue;
  DateTime _selectedYear;
  DatePickerController _controller = DatePickerController();

  List<int> _flex = [2, 2, 2, 1, 2, 1];

  @override
  void initState() {
    _selectToday();

    menus = [
      MenuModel(
        boundaryId: '11',
        count: 1,
        name: '아메리카노',
        objectId: '111',
        price: 1000,
      ),
      MenuModel(
        boundaryId: '11',
        count: 2,
        name: '에스프레소',
        objectId: '222',
        price: 3500,
      ),
    ];

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

    _histories = [
      OrderModel(
        objectId: '1',
        status: 0,
        applyTime: DateTime.now().subtract(Duration(days: 2)),
        roomNumber: '1208',
        shopName: '던킨 도넛',
        address: '마곡럭스나인오피스텔 L동',
        menus: [
          MenuModel(
            boundaryId: '11',
            count: 1,
            name: '도넛',
            objectId: '111',
            price: 1000,
          ),
        ],
        histories: [...histories],
      ),
      OrderModel(
        objectId: '2',
        status: 1,
        applyTime: DateTime.now()
            .subtract(Duration(days: 1))
            .subtract(Duration(hours: 6)),
        roomNumber: '1208',
        shopName: '고샵',
        address: '마곡럭스나인오피스텔 L동',
        menus: [
          MenuModel(
            boundaryId: '11',
            count: 1,
            name: '샴푸',
            objectId: '111',
            price: 1000,
          ),
        ],
        histories: [...histories],
      ),
      OrderModel(
        objectId: '3',
        status: 2,
        applyTime: DateTime.now()
            .subtract(Duration(days: 1))
            .subtract(Duration(hours: 3)),
        roomNumber: '1208',
        shopName: '웨스트도어',
        address: '마곡럭스나인오피스텔 L동',
        menus: [
          MenuModel(
            boundaryId: '11',
            count: 1,
            name: '아메리카노',
            objectId: '111',
            price: 1000,
          ),
        ],
        histories: [...histories],
      ),
      OrderModel(
        objectId: '4',
        status: 3,
        applyTime: DateTime.now()
            .subtract(Duration(days: 1))
            .subtract(Duration(hours: 1)),
        roomNumber: '1208',
        shopName: '봉보야쥬',
        address: '마곡럭스나인오피스텔 L동',
        menus: [
          MenuModel(
            boundaryId: '11',
            count: 1,
            name: '파스타',
            objectId: '111',
            price: 1000,
          ),
        ],
        histories: [...histories],
      ),
      OrderModel(
        objectId: '5',
        status: 4,
        applyTime: DateTime.now().subtract(Duration(hours: 3)),
        roomNumber: '1208',
        shopName: '비베러디시',
        address: '마곡럭스나인오피스텔 L동',
        menus: [
          MenuModel(
            boundaryId: '11',
            count: 1,
            name: '자몽주스',
            objectId: '111',
            price: 1000,
          ),
        ],
        histories: [...histories],
      ),
      OrderModel(
        objectId: '6',
        status: 4,
        applyTime: DateTime.now().subtract(Duration(minutes: 10)),
        roomNumber: '1208',
        shopName: '맛집',
        address: '마곡럭스나인오피스텔 L동',
        menus: [
          MenuModel(
            boundaryId: '11',
            count: 1,
            name: '맛있는 음식',
            objectId: '111',
            price: 1000,
          ),
        ],
        histories: [...histories],
      ),
    ];

    _selectedHistories =
        _histories.where((element) => _compare(element.applyTime)).toList();
    _historySort();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _moveDatePicker();
    });
  }

  _historySort() {
    _selectedHistories
        .sort((a, b) => a.applyTime.isAfter(b.applyTime) ? -1 : 1);
  }

  _compare(DateTime applyTime) {
    final Duration diff = applyTime.difference(_selectedValue);
    return diff.inHours < 24 && diff.inHours >= 0 ? true : false;
  }

  _moveDatePicker() {
    _controller.animateToDate(
      _selectedValue.subtract(Duration(days: 10)),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    _selectedHistories =
        _histories.where((element) => _compare(element.applyTime)).toList();
    _historySort();

    setState(() {});
  }

  _selectToday() {
    _selectedYear =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _selectedValue =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _yearPicker(context),
          _datePicker(),
          _row(),
          _rows(),
        ],
      ),
    );
  }

  _rows() => Expanded(
        child: ListView(
          children: List.generate(
            _selectedHistories.length,
            (index) => InkWell(
              onTap: () =>
                  AppRouter.toHistoryPage(_selectedHistories[index].objectId),
              child: _row(
                item: _selectedHistories.toList()[index],
              ),
            ),
          ),
        ),
      );

  _row({
    OrderModel item,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 26,
        ),
        decoration: item != null
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CustomColors.tableInnerBorder,
                    width: 1,
                  ),
                ),
              )
            : BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CustomColors.tableOuterBorder,
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
                          ? _rowItem(item, index)
                          : _rowTitle(index),
                    ),
                  )),
        ),
      );

  Widget _rowItem(OrderModel item, int index) {
    switch (index) {
      case 0:
        return Text(
          DateFormat("yyyy/MM/dd HH:mm:ss").format(item.applyTime).toString(),
        );
      case 1:
        return Column(
          children: [
            Text(
              item.address,
              style: TextStyle(fontSize: 13),
            ),
            Text(
              item.roomNumber,
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 2:
        return Text(item.menus.first.name);
      case 3:
        return Text('총 ${item.menus.length}개');
      case 4:
        return Text('총 ${NumberFormat().format(item.menus.first.price)}원');
      case 5:
        return Text(
          OrderStatusHelper.statusText[item.status],
          style: TextStyle(
            color: OrderStatusHelper.statusColor[item.status],
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
        return Column(
          children: [
            Text(
              '건물명',
              style: TextStyle(fontSize: 13),
            ),
            Text(
              '방번호',
              style: TextStyle(fontSize: 16),
            ),
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
      default:
        return Container();
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
          daysCount: 365,
          initialSelectedDate: _selectedValue,
          selectionColor: CustomColors.tableInnerBorder.withOpacity(.5),
          selectedTextColor: CustomColors.aBlack,
          controller: _controller,
          locale: 'ko',
          height: 90,
          dayTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          onDateChange: (DateTime date) {
            _selectedValue = DateTime(_selectedYear.year, date.month, date.day);
            setState(() {});
            _moveDatePicker();
          },
        ),
      );

  _yearPicker(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => Container(
              height: 500,
              child: CupertinoPicker(
                children: List.generate(50, (index) => _pickerItem(index)),
                scrollController: FixedExtentScrollController(
                    initialItem: DateTime.now().year - _selectedYear.year),
                onSelectedItemChanged: (int index) {
                  _selectedYear = DateTime(DateTime.now().year - index,
                      DateTime.now().month, DateTime.now().day);
                  _selectedValue = DateTime(
                    _selectedYear.year,
                    _selectedValue.month,
                    _selectedValue.day,
                  );
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _moveDatePicker();
                  });
                  // _moveDatePicker();
                  setState(() {});
                },
                backgroundColor: Colors.white,
                itemExtent: 50,
                magnification: 1.2,
              ),
            ),
          ),
          child: Text(
            _selectedYear.year.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
      );

  _pickerItem(int index) => Center(
        child: Text('${DateTime.now().year - index}'),
      );
}
