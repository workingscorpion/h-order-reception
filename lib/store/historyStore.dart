import 'dart:async';
import 'dart:convert';
import 'package:h_order_reception/http/client.dart';
import 'package:h_order_reception/http/types/updateValueModel.dart';
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
  ObservableList<HistoryDetailModel> histories = ObservableList();
  ObservableMap<int, HistoryDetailModel> historyMap = ObservableMap();
  ObservableMap<String, ServiceModel> snapShotDataMap = ObservableMap();

  @action
  load() async {
    final response = await Client.create().histories();

    histories
      ..clear()
      ..addAll(response.list);

    historyMap
      ..clear()
      ..addEntries(
          response.list.map((item) => MapEntry(item.history.index, item)));

    snapShotDataMap
      ..clear()
      ..addEntries(
        response.list
            .map(
                (item) => ServiceModel.fromJson(jsonDecode(item.snapShot.data)))
            .map((item) => MapEntry(item.objectId, item)),
      );
  }

  setStatus({
    int index,
    int status,
  }) async {
    Client.create().updateHistoryStatus(
      index,
      UpdateValueModel(value: status),
    );
  }
}
