// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoryStore on HistoryStoreBase, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: 'HistoryStoreBase.loading'))
      .value;

  final _$hubConnectionAtom = Atom(name: 'HistoryStoreBase.hubConnection');

  @override
  HubConnection get hubConnection {
    _$hubConnectionAtom.reportRead();
    return super.hubConnection;
  }

  @override
  set hubConnection(HubConnection value) {
    _$hubConnectionAtom.reportWrite(value, super.hubConnection, () {
      super.hubConnection = value;
    });
  }

  final _$isConnectedAtom = Atom(name: 'HistoryStoreBase.isConnected');

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  final _$loadingCountAtom = Atom(name: 'HistoryStoreBase.loadingCount');

  @override
  int get loadingCount {
    _$loadingCountAtom.reportRead();
    return super.loadingCount;
  }

  @override
  set loadingCount(int value) {
    _$loadingCountAtom.reportWrite(value, super.loadingCount, () {
      super.loadingCount = value;
    });
  }

  final _$streamAtom = Atom(name: 'HistoryStoreBase.stream');

  @override
  Stream<PushNotificationModel> get stream {
    _$streamAtom.reportRead();
    return super.stream;
  }

  @override
  set stream(Stream<PushNotificationModel> value) {
    _$streamAtom.reportWrite(value, super.stream, () {
      super.stream = value;
    });
  }

  final _$connectHubAsyncAction = AsyncAction('HistoryStoreBase.connectHub');

  @override
  Future connectHub() {
    return _$connectHubAsyncAction.run(() => super.connectHub());
  }

  final _$loadAsyncAction = AsyncAction('HistoryStoreBase.load');

  @override
  Future load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  final _$loadFromDateAsyncAction =
      AsyncAction('HistoryStoreBase.loadFromDate');

  @override
  Future loadFromDate({List<int> status, DateTime date}) {
    return _$loadFromDateAsyncAction
        .run(() => super.loadFromDate(status: status, date: date));
  }

  final _$singleAsyncAction = AsyncAction('HistoryStoreBase.single');

  @override
  Future<RecordModel> single({String index}) {
    return _$singleAsyncAction.run(() => super.single(index: index));
  }

  @override
  String toString() {
    return '''
hubConnection: ${hubConnection},
isConnected: ${isConnected},
loadingCount: ${loadingCount},
stream: ${stream},
loading: ${loading}
    ''';
  }
}
