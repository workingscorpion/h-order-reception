import 'dart:async';
import 'package:h_order_reception/http/client.dart';
import 'package:h_order_reception/model/historyModel.dart';
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

  @action
  load() async {
    final response = await Client.create().histories();
    final list = response.list;

    histories
      ..clear()
      ..addAll(list);

    historyMap
      ..clear()
      ..addEntries(list.map((item) => MapEntry(item.objectId, item)));
  }
}
