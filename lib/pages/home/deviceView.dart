import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/deviceModel.dart';
import 'package:intl/intl.dart';

class DeviceView extends StatefulWidget {
  DeviceView({Key key}) : super(key: key);

  @override
  _DeviceViewState createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  List<DeviceModel> devices = List<DeviceModel>();
  List<DeviceModel> filteredDevices = List<DeviceModel>();
  DateTime lastRefreshTime;

  bool isAll;

  List<int> ratio = [2, 2, 2, 2, 2];

  @override
  void initState() {
    super.initState();

    _load();

    isAll = true;
  }

  void _load() {
    // TODO: load data
    filteredDevices = [...devices].toList();
    lastRefreshTime = DateTime.now();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          _header(),
          Expanded(
            child: Column(
              children: [
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _header() => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            _filterButton(callBack: () => _filter(isAll: true), text: 'ALL'),
            _filterButton(callBack: () => _filter(isAll: false), text: 'OFF'),
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Text('마지막 새로고침 - '),
            ),
            _refreshData(),
            _filterButton(callBack: _load, text: 'REFRESH'),
          ],
        ),
      );

  _filter({bool isAll}) {
    filteredDevices =
        devices.where((e) => isAll ? e.state == 0 : e.state == 1).toList();
    isAll = isAll;
    setState(() {});
  }

  _filterButton({
    callBack,
    String text,
  }) =>
      Container(
        margin: EdgeInsets.only(right: 10),
        child: OutlineButton(
          onPressed: callBack,
          child: Container(
            alignment: Alignment.center,
            width: 150,
            height: 50,
            child: Text(
              text,
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 25),
            ),
          ),
          borderSide: BorderSide(
            color: (isAll == true && text == 'ALL') ||
                    (isAll == false && text == 'OFF') ||
                    (text == 'REFRESH')
                ? Theme.of(context).accentColor
                : CustomColors.tableInnerBorder,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
      );

  _refreshData() => Container(
        margin: EdgeInsets.only(right: 10),
        child: Text(
          DateFormat('HH : mm : ss').format(lastRefreshTime).toString(),
          style: Theme.of(context).textTheme.bodyText2,
        ),
      );

  // _refreshItem() {
  //   load
  // }

  // _row({
  //   List<Widget> children,
  // }) =>
  //     Container(
  //       padding: EdgeInsets.symmetric(
  //         vertical: 16,
  //         horizontal: 26,
  //       ),
  //       child: Row(
  //         children: [
  //           ...[]
  //               .asMap()
  //               .map(
  //                 (index, item) => MapEntry(
  //                   index,
  //                   Expanded(
  //                     flex: ratio[index],
  //                     child: Container(
  //                       padding: index != children.length - 1
  //                           ? EdgeInsets.only(right: 10)
  //                           : EdgeInsets.zero,
  //                       child: item,
  //                     ),
  //                   ),
  //                 ),
  //               )
  //               .values,
  //         ],
  //       ),
  //     );
}
