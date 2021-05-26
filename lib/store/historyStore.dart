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

  static final activeStatus = [1, 2, 3, 4];

  @action
  load() async {
    final response = await Client.create().historyDetails(
      activeStatus.map((item) => 'filter.status=$item').join('&'),
      'UpdatedTime',
    );

    historyDetails
      ..clear()
      ..addAll(response.list);

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
    String message,
  }) async {
    final item = await Client.create().updateHistoryStatus(
      index,
      UpdateHistoryStatusModel(
        status: status,
        data: (message?.isNotEmpty ?? false)
            ? jsonEncode({
                message: message,
              })
            : '',
      ),
    );

    final listIndex = historyDetails
        .indexWhere((item) => item.history.index == item.history.index);

    if (activeStatus.contains(item.history.status)) {
      if (listIndex != -1) {
        historyDetails
          ..removeAt(listIndex)
          ..insert(0, item);
      } else {
        historyDetails..add(item);
      }
    } else {
      if (listIndex != -1) {
        historyDetails..removeAt(listIndex);
      }
    }

    historyDetailMap[item.history.index] = item;
    snapShotDataMap[item.snapShot.objectId] =
        ServiceModel.fromJson(jsonDecode(item.snapShot.data));
  }
}
