import 'dart:async';
import 'package:flutter/material.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/http/api/authApi.dart';
import 'package:h_order_reception/http/client.dart';
import 'package:h_order_reception/http/types/login/requestLogin.dart';
import 'package:h_order_reception/http/types/login/responseLogin.dart';
import 'package:h_order_reception/utils/fcmManager.dart';
import 'package:h_order_reception/utils/lazy.dart';
import 'package:h_order_reception/utils/sharedPreferencesHelper.dart';
import 'package:mobx/mobx.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/http.dart' hide Client;
import 'package:http/io_client.dart';

part 'userInfoStore.g.dart';

class UserInfoStore extends UserInfoStoreBase with _$UserInfoStore {
  static final Lazy<UserInfoStore> _lazy =
      Lazy<UserInfoStore>(() => new UserInfoStore());

  static UserInfoStore get instance => _lazy.value;
}

abstract class UserInfoStoreBase with Store {
  @observable
  String fcmToken;

  @observable
  String id;

  @observable
  bool loading = false;

  @observable
  bool isLogin = false;

  @observable
  bool isInitialized = false;

  @observable
  HubConnection hubConnection;

  @observable
  bool isConnected = false;

  @observable
  Stream<PushNotificationModel> stream =
      Stream<PushNotificationModel>.empty().asBroadcastStream();

  @action
  setLoginInfo(String identity, String token) async {
    if (identity != null) {
      await SharedPreferencesHelper.setUserId(identity);
    } else {
      await SharedPreferencesHelper.removeUserId();
    }

    if (token != null) {
      await SharedPreferencesHelper.setJWTToken(token);
    } else {
      await SharedPreferencesHelper.removeJWTToken();
    }
  }

  @action
  login({
    String id,
    String password,
  }) async {
    try {
      if (loading) {
        return;
      }

      loading = true;

      final String token = await SharedPreferencesHelper.getJWTToken();

      var response = await AuthApi.login(
        RequestLogin(
          id: id,
          password: password ?? '',
          token: token ?? '',
        ),
      );

      final user = ResponseLogin.fromJson(response.data);

      setLoginInfo(user.identity, user.token);
    } catch (ex) {
      return Future.error(ex);
    } finally {
      loading = false;
    }
  }

  @action
  logout() async {
    return await showDialog(
      context: AppRouter.context,
      child: AlertDialog(
        title: Text('로그아웃 하시겠습니까?'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: FlatButton(
              onPressed: () {
                AppRouter.pop();
              },
              child: Text(
                '취소',
                style: Theme.of(AppRouter.context).textTheme.bodyText2,
              ),
            ),
          ),
          FlatButton(
            onPressed: () async {
              AuthApi.logout(true);

              setLoginInfo(null, null);

              AppRouter.toLoginPage();
            },
            child: new Text(
              '로그아웃',
              style: Theme.of(AppRouter.context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }

  @action
  Future<String> getFcmToken() async {
    if (fcmToken == null) {
      fcmToken = await FCMManger.instance.getFirebaseMessageToken();
    }
    return fcmToken;
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
    final list = Client.cookieJar.loadForRequest(request.url);
    final cookie = list.map((e) => '${e.name}=${e.value};').join(' ');
    request.headers['Cookie'] = cookie;

    return super.send(request);
  }
}
