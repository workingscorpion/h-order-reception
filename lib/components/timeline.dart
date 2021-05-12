import 'package:flutter/material.dart';
import 'package:h_order_reception/model/historyModel.dart';

class Timeline extends StatelessWidget {
  Timeline({this.histories});

  final List<HistoryModel> histories;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      // children: _timelines(),
    );
  }

  // _timelines() => List.generate(
  //     histories.length, (index) => _timeline(histories[index], index));

  // Widget _timeline(HistoryModel item, int index) => TimelineTile(
  //       axis: TimelineAxis.vertical,
  //       alignment: TimelineAlign.manual,
  //       lineXY: .1,
  //       indicatorStyle: IndicatorStyle(
  //         width: 35,
  //         height: 50,
  //         indicator: Container(
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //             color: OrderStatusHelper.statusColor[item.status],
  //             shape: BoxShape.circle,
  //           ),
  //           child: Text(
  //             '${histories.length - (index)}',
  //             style: TextStyle(
  //               color: item.status >= 4 ? Colors.black : Colors.white,
  //             ),
  //           ),
  //         ),
  //       ),
  //       afterLineStyle: LineStyle(
  //         color: CustomColors.doneColor,
  //         thickness: 2,
  //       ),
  //       beforeLineStyle: LineStyle(
  //         color: CustomColors.doneColor,
  //         thickness: 2,
  //       ),
  //       isFirst: index <= 0 ? true : false,
  //       isLast: histories.length <= index + 1 ? true : false,
  //       endChild: Container(
  //         padding: EdgeInsets.only(left: 10),
  //         alignment: Alignment.centerLeft,
  //         child: Text(
  //           "${DateFormat('yyyy-MM-dd HH:mm:ss').format(item.updatedDate)}\n'${item.updaterName}'님이 '${OrderStatusHelper.statusText[item.status]}'로 수정",
  //           style: TextStyle(color: Colors.black),
  //         ),
  //       ),
  //     );
}
