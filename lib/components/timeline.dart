import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/historyDetailItemModel.dart';
import 'package:h_order_reception/model/recordModel.dart';
import 'package:h_order_reception/store/historyStore.dart';
import 'package:h_order_reception/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Timeline extends StatefulWidget {
  final int historyIndex;
  // final List<History>

  Timeline({
    this.historyIndex,
  });

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  RecordModel get historyDetail {
    return HistoryStore.instance.historyDetailMap[widget.historyIndex];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        ...List.generate(
            historyDetail.details?.length ?? 0,
            (index) => _item(
                  index: index,
                  item: historyDetail.details[index],
                )),
      ],
    );
  }

  _item({
    int index,
    HistoryDetailItemModel item,
  }) =>
      TimelineTile(
        axis: TimelineAxis.vertical,
        alignment: TimelineAlign.manual,
        lineXY: .1,
        indicatorStyle: IndicatorStyle(
          width: 35,
          height: 50,
          indicator: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: orderStatus[item.status].color,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${historyDetail.details.length - index}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        afterLineStyle: LineStyle(
          color: CustomColors.doneColor,
          thickness: 2,
        ),
        beforeLineStyle: LineStyle(
          color: CustomColors.doneColor,
          thickness: 2,
        ),
        isFirst: index == 0,
        isLast: index == historyDetail.details.length - 1,
        endChild: Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${DateFormat('yyyy-MM-dd HH:mm:ss').format(item.createdTime)}',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                "'${item.userName}'님이 '${orderStatus[item.status].name}' 상태로 수정",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
}
