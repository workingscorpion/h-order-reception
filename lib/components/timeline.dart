import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  final int historyIndex;

  Timeline({this.historyIndex});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        //   ...List.generate(
        // widget.historyIndex.length, (index) => _timeline(histories[index], index)),
      ],
    );
  }

  //  _timeline(HistoryModel item, int index) => TimelineTile(
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
