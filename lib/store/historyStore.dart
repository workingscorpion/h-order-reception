import 'dart:async';
import 'dart:convert';
import 'package:h_order_reception/http/client.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/snapShotModel.dart';
import 'package:h_order_reception/utils/lazy.dart';
import 'package:mobx/mobx.dart';

part 'historyStore.g.dart';

class HistoryStore extends HistoryStoreBase with _$HistoryStore {
  static final Lazy<HistoryStore> _lazy =
      Lazy<HistoryStore>(() => new HistoryStore());

  static HistoryStore get instance => _lazy.value;
}

abstract class HistoryStoreBase with Store {
  ObservableList<HistoryModel> histories = ObservableList();
  ObservableMap<String, HistoryModel> historyMap = ObservableMap();

  ObservableList<SnapShotModel> snapShots = ObservableList();
  ObservableMap<String, Map> snapShotDataMap = ObservableMap();

  @action
  load() async {
    final response = await Client.create().histories();

    histories
      ..clear()
      ..addAll(response.list);

    historyMap
      ..clear()
      ..addEntries(response.list.map((item) => MapEntry(item.objectId, item)));

    snapShots
      ..clear()
      ..addAll(response.data);

    snapShotDataMap
      ..clear()
      ..addEntries(response.data
          .map((e) => jsonDecode(e.data))
          .map((e) => MapEntry(e['objectId'], e)));
  }
}
