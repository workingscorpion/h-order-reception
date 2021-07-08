import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/http/types/subTypes/notificationData.dart';
import 'package:h_order_reception/store/navigationStore.dart';
import 'package:h_order_reception/store/userInfoStore.dart';
import 'package:h_order_reception/utils/lazy.dart';
import 'package:h_order_reception/utils/sharedPreferencesHelper.dart';

import 'constants.dart';

class FCMManger {
  static final Lazy<FCMManger> _lazy = Lazy<FCMManger>(() => FCMManger());
  static FCMManger get instance => _lazy.value;
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  get isLogin => UserInfoStore.instance.isLogin;

  Future<String> _getFCMTokenFromFCMServer() async {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    String _token = await _firebaseMessaging.getToken();
    return _token;
  }

  Future<String> getFirebaseMessageToken() async {
    String fcmToken = await SharedPreferencesHelper.getFCMToken();
    if (fcmToken == null) {
      fcmToken = await _getFCMTokenFromFCMServer();
      SharedPreferencesHelper.setFCMToken(fcmToken);
    }
    return fcmToken;
  }

  tryLogin() async {
    try {
      final String id = await SharedPreferencesHelper.getUserId();
      if (id == null) {
        throw Exception();
      }

      UserInfoStore.instance.login(id: id);

      return isLogin;
    } catch (ex) {
      return false;
    }
  }

  initialize() async {
    _configFcm();
    _configLocalNotification();
  }

  _configFcm() {
    if (Platform.isIOS) {
      iosPermission();
    }

    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        final data =
            (Platform.isAndroid ? message['data'] : message) ?? message;

        final notificationData = NotificationData(
          type: data['type'],
          objectId: data['objectId'],
          data: data['data'],
        );

        NavigationStore.instance.launchNotification = notificationData;
      },
      onMessage: (Map<String, dynamic> message) async {
        _showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        if (isLogin == false && await tryLogin()) {
          return;
        }

        // final data =
        //     (Platform.isAndroid ? message['data'] : message) ?? message;

        // final notificationData = NotificationData(
        //   type: data['type'],
        //   url: data['hotelUrl'],
        //   objectId: data['objectId'],
        //   data: data['data'],
        // );

        // openNotification(notificationData);
      },
    );
  }

  _configLocalNotification() {
    final android = AndroidInitializationSettings('app_icon');
    final ios = IOSInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: null,
    );

    final settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    NavigationStore.instance.appKey.currentState.flutterLocalNotificationsPlugin
        .initialize(
      settings,
      onSelectNotification: (payload) async {
        await _onSelectNotification(payload);
      },
    );
  }

  iosPermission() {
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));

    _firebaseMessaging.onIosSettingsRegistered.listen(
      (IosNotificationSettings settings) {},
    );
  }

  _onSelectNotification(String payload) async {
    final data = NotificationData.fromJson(json.decode(payload));

    if (UserInfoStore.instance.isInitialized) {
      if (isLogin == false && await tryLogin()) {
        return;
      }

      openNotification(data);
    } else {
      NavigationStore.instance.launchNotification = data;
    }
  }

  openNotification(NotificationData data) async {
    AppRouter.toHomePage();
  }

  _showNotification(Map<String, dynamic> message) async {
    final android = AndroidNotificationDetails(
      NotificationChannelId,
      NotificationChannelName,
      NotificationChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      channelShowBadge: true,
    );

    final ios = IOSNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
    );

    final channel = NotificationDetails(
      android: android,
      iOS: ios,
    );

    final notification = message['notification'] ?? message;
    // final data = (Platform.isAndroid ? message['data'] : message) ?? message;
    final title = notification['title'];
    final body = notification['body'];

    // final notificationData = NotificationData(
    //   type: data['type'],
    //   url: data['hotelUrl'],
    //   objectId: data['objectId'],
    //   data: data['data'],
    // );

    // final payload = jsonEncode(notificationData);

    await NavigationStore
        .instance.appKey.currentState.flutterLocalNotificationsPlugin
        .show(0, title, body, channel,
            // payload: payload,
            payload: '');
  }
}
