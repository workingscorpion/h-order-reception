import 'dart:async';
import 'dart:convert';
import 'package:h_order_reception/http/client.dart';
import 'package:h_order_reception/http/types/updateHistoryStatusModel.dart';
import 'package:h_order_reception/model/historyDetailModel.dart';
import 'package:h_order_reception/model/serviceModel.dart';
import 'package:h_order_reception/utils/lazy.dart';
import 'package:mobx/mobx.dart';

part 'historyStore.g.dart';

class HistoryStore extends HistoryStoreBase with _$HistoryStore {
  static final Lazy<HistoryStore> _lazy =
      Lazy<HistoryStore>(() => new HistoryStore());

  static HistoryStore get instance => _lazy.value;
}

abstract class HistoryStoreBase with Store {
  ObservableList<HistoryDetailModel> historyDetails = ObservableList();
  ObservableMap<int, HistoryDetailModel> historyDetailMap = ObservableMap();
  ObservableMap<String, ServiceModel> snapShotDataMap = ObservableMap();

  @action
  load() async {
    final response = await Client.create().historyDetails(
      [1, 2, 3, 4].join(','),
      'UpdatedTime',
    );

    historyDetails
      ..clear()
      ..addAll(response.list)
      ..sort((a, b) =>
          a.history.updatedTime.isAfter(b.history.updatedTime) ? -1 : 1);

    historyDetailMap
      ..clear()
      ..addEntries(
          response.list.map((item) => MapEntry(item.history.index, item)));

    snapShotDataMap
      ..clear()
      ..addEntries(
        response.list.map(
          (item) => MapEntry(
            item.snapShot.objectId,
            ServiceModel.fromJson(jsonDecode(item.snapShot.data)),
          ),
        ),
      );
  }

  setStatus({
    int index,
    int status,
  }) async {
    final item = await Client.create().updateHistoryStatus(
      index,
      UpdateHistoryStatusModel(
        status: status,
        data: '',
      ),
    );

    final listIndex = historyDetails
        .indexWhere((item) => item.history.index == item.history.index);

    if (item.history.status == 9) {
      if (listIndex != -1) {
        historyDetails..removeAt(listIndex);
      }
    } else {
      if (listIndex != -1) {
        historyDetails..replaceRange(listIndex, listIndex + 1, [item]);
      } else {
        historyDetails..add(item);
      }
    }

    historyDetailMap[item.history.index] = item;
    snapShotDataMap[item.snapShot.objectId] =
        ServiceModel.fromJson(jsonDecode(item.snapShot.data));
  }
}
