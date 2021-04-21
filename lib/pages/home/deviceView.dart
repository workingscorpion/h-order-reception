import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h_order_reception/components/collapsible.dart';
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
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          _header(),
          Expanded(
            child: Column(
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  child: Container(
                    color: Theme.of(context).accentColor,
                    child: _row(
                      flex: ratio,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '호실 번호',
                          ),
                        ),
                        Text(
                          '상태',
                        ),
                        Text(
                          '배터리',
                        ),
                        Text(
                          '충전 여부',
                        ),
                        Text(
                          '마지막 확인 시간',
                        ),
                      ],
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    child: Container(
                      decoration: BoxDecoration(),
                      child: ListView(
                        children: [
                          ...filteredDevices.map(
                            (item) => _item(
                                flex: ratio,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      '${item.roomNumber}',
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: item.state == 0
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      Text(item.state == 0 ? 'ON' : 'OFF')
                                    ],
                                  ),
                                  Text(
                                    '${item.battery}%',
                                  ),
                                  Text(
                                    '${item.isCharging ? "충전 중" : "-"}',
                                  ),
                                  Text(
                                    '${DateFormat('yyyy/MM/dd').format(item.lastLiveTime)}',
                                  ),
                                ],
                                // content: item.content,
                                content: null),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _header() => Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
    filteredDevices = devices.where((e) => isAll ? e : e.state == 1).toList();
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

  _row({
    List<int> flex,
    List<Widget> children,
    Color color,
  }) =>
      Container(
        color: color,
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 26,
        ),
        child: Row(
          children: [
            ...children
                .asMap()
                .map(
                  (index, item) => MapEntry(
                    index,
                    Expanded(
                      flex: flex[index],
                      child: Container(
                        padding: index < children.length - 1
                            ? EdgeInsets.only(right: 10)
                            : EdgeInsets.zero,
                        child: item,
                      ),
                    ),
                  ),
                )
                .values,
          ],
        ),
      );

  _item({
    List<int> flex,
    List<Widget> children,
    String content,
  }) =>
      Collapsible(
        header: _row(
          flex: flex,
          children: children,
          color: Colors.transparent,
        ),
        body: Container(
          padding: EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border(
              top: BorderSide(
                color: CustomColors.tableInnerBorder,
              ),
            ),
          ),
          child: Container(
            // FIXME: 내부 사이즈에 맞춰 height size fix
            height: 500,
            child: Container(
              child: Text('collapse contents'),
            ),
          ),
        ),
      );
}
