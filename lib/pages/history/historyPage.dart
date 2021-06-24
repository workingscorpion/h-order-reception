import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/components/menu.dart';
import 'package:h_order_reception/components/refuseDialog.dart';
import 'package:h_order_reception/components/timeline.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/http/client.dart';
import 'package:h_order_reception/model/recordModel.dart';
import 'package:h_order_reception/store/historyStore.dart';
import 'package:h_order_reception/store/userInfoStore.dart';
import 'package:h_order_reception/utils/constants.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({this.historyIndex});

  final String historyIndex;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  RecordModel record;

  final List<String> _infoTitles = ['건물정보', '방번호', '발생시간', '서비스명'];

  List<String> _infoData;

  int status;
  OrderStatusModel statusData;

  List<RecordModel> get histories {
    return HistoryStore.instance.historyDetails ?? List();
  }

  @override
  void initState() {
    _load();

    super.initState();
  }

  _load() async {
    await HistoryStore.instance.load();

    record = await Client.create().historyDetail(widget.historyIndex);
    // TODO
    _infoData = [
      '건물명',
      record.history.deviceName,
      DateFormat().format(record.history.createdTime),
      '${UserInfoStore.instance.name}',
    ];
    status = record.history.status;
    statusData = orderStatus[status];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _header(),
              _statuses(),
              Builder(
                builder: (BuildContext context) => record != null
                    ? Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _history(),
                              Container(width: 15),
                              _menu(),
                              Container(width: 15),
                              _info(),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _info() => Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: CustomColors.doneColor, width: 1),
                ),
                child: Column(
                  children: List.generate(4, (index) => _infoItem(index)),
                ),
              ),
            ),
            Container(height: 10),
            InkWell(
              onTap: () async {
                final result = await showDialog(
                  context: context,
                  child: RefuseDialog(
                    historyIndex: int.parse(widget.historyIndex),
                    status: record.history.status,
                  ),
                );
                if (result == null) {
                  return;
                }

                final message = result as String;

                HistoryStore.instance.setStatus(
                  index: int.parse(widget.historyIndex),
                  status: record.history.status == 1 ? -9 : -1,
                  message: message,
                );
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColors.denyColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  record.history.status == 1 ? '거절' : '취소',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );

  _infoItem(int index) => Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Text(
              _infoTitles[index],
              style: TextStyle(fontSize: 17),
            ),
            Spacer(),
            Text(
              _infoData[index],
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  _menu() => Expanded(
        flex: 4,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CustomColors.doneColor, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicHeight(
                child: Menu(historyIndex: record.history.index),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: _amount(),
              ),
            ],
          ),
        ),
      );

  _amount() => Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: CustomColors.doneColor, width: 1),
          ),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 22,
            color: CustomColors.aBlack,
          ),
          child: Row(
            children: [
              Text('총'),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(record.history.quantity != null
                    ? '${record.history.quantity}개'
                    : ''),
              ),
              Text(record.history.amount != null
                  ? '${NumberFormat().format(record.history.amount)}원'
                  : '-'),
            ],
          ),
        ),
      );

  _history() => Expanded(
        flex: 4,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CustomColors.doneColor, width: 1),
          ),
          child: Timeline(historyIndex: record.history.index),
        ),
      );

  _header() => Container(
        height: 50,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => AppRouter.pop(),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        EdgeInsets.only(left: 4, right: 5, top: 9, bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: CustomColors.doneColor),
                    ),
                    child: Icon(
                      CupertinoIcons.chevron_left,
                      size: 18,
                    ),
                  ),
                  Text(
                    '주문현황',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      );

  isShop() => false;

  _statuses() => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: List.generate(
            3,
            (index) => index == 2 ? _status(9) : _status(index + 1),
          ),
        ),
      );

  _status(int statusValue) => Expanded(
        child: InkWell(
          onTap: () async {
            status = statusValue;
            await HistoryStore.instance.setStatus(
              index: int.parse(widget.historyIndex),
              status: statusValue,
            );
            _load();
            setState(() {});
          },
          child: Container(
            height: 50,
            margin:
                statusValue != 5 ? EdgeInsets.only(right: 15) : EdgeInsets.zero,
            decoration: BoxDecoration(
              color: statusValue == status
                  ? orderStatus[statusValue].color
                  : CustomColors.evenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              orderStatus[statusValue]?.name ?? '',
              style: TextStyle(
                color: statusValue == status && status != 4
                    ? Colors.white
                    : Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
}
