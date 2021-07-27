// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfoStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserInfoStore on UserInfoStoreBase, Store {
  final _$fcmTokenAtom = Atom(name: 'UserInfoStoreBase.fcmToken');

  @override
  String get fcmToken {
    _$fcmTokenAtom.reportRead();
    return super.fcmToken;
  }

  @override
  set fcmToken(String value) {
    _$fcmTokenAtom.reportWrite(value, super.fcmToken, () {
      super.fcmToken = value;
    });
  }

  final _$idAtom = Atom(name: 'UserInfoStoreBase.id');

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$nameAtom = Atom(name: 'UserInfoStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$loadingAtom = Atom(name: 'UserInfoStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$isLoginAtom = Atom(name: 'UserInfoStoreBase.isLogin');

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  final _$isInitializedAtom = Atom(name: 'UserInfoStoreBase.isInitialized');

  @override
  bool get isInitialized {
    _$isInitializedAtom.reportRead();
    return super.isInitialized;
  }

  @override
  set isInitialized(bool value) {
    _$isInitializedAtom.reportWrite(value, super.isInitialized, () {
      super.isInitialized = value;
    });
  }

  final _$hubConnectionAtom = Atom(name: 'UserInfoStoreBase.hubConnection');

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

  final _$isConnectedAtom = Atom(name: 'UserInfoStoreBase.isConnected');

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

  final _$setLoginInfoAsyncAction =
      AsyncAction('UserInfoStoreBase.setLoginInfo');

  @override
  Future setLoginInfo(String identity, String token) {
    return _$setLoginInfoAsyncAction
        .run(() => super.setLoginInfo(identity, token));
  }

  final _$loginAsyncAction = AsyncAction('UserInfoStoreBase.login');

  @override
  Future login({String id, String password, String fcmToken}) {
    return _$loginAsyncAction
        .run(() => super.login(id: id, password: password, fcmToken: fcmToken));
  }

  final _$logoutAsyncAction = AsyncAction('UserInfoStoreBase.logout');

  @override
  Future logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$getFcmTokenAsyncAction = AsyncAction('UserInfoStoreBase.getFcmToken');

  @override
  Future<String> getFcmToken() {
    return _$getFcmTokenAsyncAction.run(() => super.getFcmToken());
  }

  @override
  String toString() {
    return '''
fcmToken: ${fcmToken},
id: ${id},
name: ${name},
loading: ${loading},
isLogin: ${isLogin},
isInitialized: ${isInitialized},
hubConnection: ${hubConnection},
isConnected: ${isConnected}
    ''';
  }
}
