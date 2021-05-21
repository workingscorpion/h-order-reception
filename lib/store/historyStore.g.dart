// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoryStore on HistoryStoreBase, Store {
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

  @override
  String toString() {
    return '''
hubConnection: ${hubConnection},
isConnected: ${isConnected},
stream: ${stream}
    ''';
  }
}
