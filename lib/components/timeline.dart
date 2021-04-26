import 'package:flutter/material.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/utils/orderStatusHelper.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Timeline extends StatelessWidget {
  Timeline({this.histories});

  final List<HistoryModel> histories;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _timelines(),
    );
  }

  _timelines() => List.generate(
      histories.length, (index) => _timeline(histories[index], index));

  Widget _timeline(HistoryModel item, int index) => TimelineTile(
        axis: TimelineAxis.vertical,
        alignment: TimelineAlign.manual,
        lineXY: 0.1,
        indicatorStyle: IndicatorStyle(
          indicator: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: OrderStatusHelper.statusColor[item.status],
              shape: BoxShape.circle,
            ),
            child: Wrap(
              children: [
                Text(
                  '${histories.length - (index)}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          color: Colors.grey,
        ),
        isFirst: index <= 0 ? true : false,
        isLast: histories.length <= index + 1 ? true : false,
        endChild: Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            "${DateFormat('yyyy-MM-dd HH:mm:ss').format(item.updatedDate)}\n'${item.updaterName}'님이 '${OrderStatusHelper.statusText[item.status]}'로 수정",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
