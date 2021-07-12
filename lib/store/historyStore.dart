import 'dart:async';
import 'dart:convert';
import 'package:h_order_reception/http/client.dart';
import 'package:h_order_reception/http/types/updateHistoryStatusModel.dart';
import 'package:h_order_reception/model/recordModel.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/serviceModel.dart';
import 'package:h_order_reception/utils/lazy.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' hide Client;

part 'historyStore.g.dart';

class HistoryStore extends HistoryStoreBase with _$HistoryStore {
  static final Lazy<HistoryStore> _lazy =
      Lazy<HistoryStore>(() => new HistoryStore());

  static HistoryStore get instance => _lazy.value;
}

abstract class HistoryStoreBase with Store {
  ObservableList<RecordModel> historyDetails = ObservableList();
  ObservableMap<int, RecordModel> historyDetailMap = ObservableMap();
  ObservableMap<String, ServiceModel> snapShotDataMap = ObservableMap();
  ObservableMap<String, List<RecordModel>> historyDetailsFromDateMap =
      ObservableMap();

  @observable
  HubConnection hubConnection;

  @observable
  bool isConnected = false;

  @observable
  int loadingCount = 0;

  @computed
  bool get loading => loadingCount > 0;

  static final activeStatus = [1, 2, 3, 4];

  @observable
  Stream<PushNotificationModel> stream =
      Stream<PushNotificationModel>.empty().asBroadcastStream();

  @action
  connectHub() async {
    if (Client.token?.isEmpty ?? true) {
      return;
    }

    if (hubConnection != null) {
      hubConnection.stop();
    }

    hubConnection = HubConnectionBuilder()
        .withUrl(
          Client.signalRUrl,
          HttpConnectionOptions(
            client: SignalRClient(),
            logging: (level, message) {
              print('### $level $message');
            },
          ),
        )
        .withAutomaticReconnect()
        .build();

    hubConnection.on('notified', (json) async {
      final map = json.first as Map;
      HistoryModel.fromJson(map);
      await load();
      // var target = historyDetails
      //     .singleWhere((element) => element.history.index == data.index);
      // if (target != null) {
      //   target.history = data;
      // } else {
      //   await load();
      // }
    });

    await hubConnection.start();
  }

  @action
  load() async {
    try {
      loadingCount += 1;

      final response = await Client.create().historyDetails(
        activeStatus.map((item) => 'filter.status=$item').join('&'),
        'UpdatedTime',
      );
      final details = response.list;

      details.sort((a, b) =>
          a.history.createdTime.isAfter(b.history.createdTime) ? 1 : -1);

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
              item.snapShot != null ? item.snapShot.objectId : '123',
              ServiceModel.fromJson(jsonDecode(item.snapShot.data)),
            ),
          ),
        );
    } finally {
      loadingCount -= 1;
    }
  }

  @action
  loadFromDate({List<int> status, DateTime date}) async {
    try {
      loadingCount += 1;

      final response = await Client.create().historyDetails(
        status.map((item) => 'filter.status=$item').join('&'),
        'CreatedTime',
        startTime: DateFormat('yyyy-MM-dd').format(date),
        endTime: DateFormat('yyyy-MM-dd').format(date.add(Duration(days: 1))),
      );
      final details = response.list;

      final key = DateFormat('yyyy-MM-dd').format(date);
      if (!historyDetailsFromDateMap.containsKey(key)) {
        historyDetailsFromDateMap[key] = List();
      }

      historyDetailsFromDateMap[key]
        ..clear()
        ..addAll(details);

      details.forEach((item) {
        upsert(item);
      });
    } finally {
      loadingCount -= 1;
    }
  }

  setStatus({
    int index,
    int status,
    String message,
  }) async {
    try {
      loadingCount += 1;
      final item = await Client.create().updateHistoryStatus(
        index,
        UpdateHistoryStatusModel(
          status: status,
          data: (message?.isNotEmpty ?? false)
              ? jsonEncode({
                  "message": message,
                })
              : '',
        ),
      );
      upsert(item);
    } finally {
      loadingCount -= 1;
    }
  }

  @action
  Future<RecordModel> single({String index}) async {
    try {
      loadingCount += 1;

      final item = await Client.create().historyDetail(index);
      upsert(item);
      return item;
    } finally {
      loadingCount -= 1;
    }
  }

  upsert(RecordModel item) {
    final listIndex = historyDetails
        .indexWhere((_item) => _item.history.index == item.history.index);

    if (activeStatus.contains(item.history.status)) {
      if (listIndex != -1) {
        historyDetails[listIndex] = item;
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

    final key = DateFormat('yyyy-MM-dd').format(item.history.createdTime);
    if (!historyDetailsFromDateMap.containsKey(key)) {
      historyDetailsFromDateMap[key] = List();
    }

    final listIndexFromDate = historyDetailsFromDateMap[key]
        .indexWhere((_item) => _item.history.index == item.history.index);
    if (listIndexFromDate != -1) {
      historyDetailsFromDateMap[key][listIndexFromDate] = item;
    } else {
      historyDetailsFromDateMap[key]..add(item);
    }
  }
}

class PushNotificationModel {
  final int type;
  final String hotelUrl;
  final String hotelObjectId;
  final String targetObjectId;
  final dynamic data;

  PushNotificationModel({
    this.type,
    this.hotelUrl,
    this.hotelObjectId,
    this.targetObjectId,
    this.data,
  });
}

class SignalRClient extends IOClient {
  @override
  Future<IOStreamedResponse> send(BaseRequest request) async {
    request.headers['Authorization'] = 'Bearer ${Client.token}';

    return super.send(request);
  }
}
