import 'dart:async';
import 'dart:convert';
import 'package:h_order_reception/http/client.dart';
import 'package:h_order_reception/http/types/updateHistoryStatusModel.dart';
import 'package:h_order_reception/model/historyDetailModel.dart';
import 'package:h_order_reception/model/serviceModel.dart';
import 'package:h_order_reception/utils/lazy.dart';
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
  ObservableList<HistoryDetailModel> historyDetails = ObservableList();
  ObservableMap<int, HistoryDetailModel> historyDetailMap = ObservableMap();
  ObservableMap<String, ServiceModel> snapShotDataMap = ObservableMap();

  @observable
  HubConnection hubConnection;

  @observable
  bool isConnected = false;

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

    hubConnection.on('notified', (json) {
      final map = json.first as Map;
      print(map.toString());
      // if (map['type'] != null) {
      //   final type = map['type'] as int;
      //   final targetObjectId = map['targetObjectId'] as String;

      //   print(type.toString());
      //   print(targetObjectId);
      // }
    });

    await hubConnection.start();
  }

  @action
  load() async {
    final response = await Client.create().historyDetails(
      activeStatus.map((item) => 'filter.status=$item').join('&'),
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
            item.snapShot != null ? item.snapShot.objectId : '123',
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
