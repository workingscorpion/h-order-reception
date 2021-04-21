import 'package:dio/dio.dart';
import 'package:h_order_reception/http/types/login/requestLogin.dart';

import '../client.dart';

class RequestCodeType {
  final int value;

  RequestCodeType(this.value);

  static final register = RequestCodeType(0);
  static final findId = RequestCodeType(1);
  static final findPassword = RequestCodeType(2);
}

class AuthApi {
  static const String apiPath = 'v1/Auth';

  static Future<Response> login(RequestLogin requestLogin) async {
    return await Client.post('$apiPath/login', json: requestLogin.toJson());
  }

  // static Future<String> changePassword(
  //     RequestChangePassword requestChangePassword) async {
  //   Response response = await Client.post('auth/password',
  //       json: requestChangePassword.toJson());
  //   if (response.statusCode == 200) {
  //     return "signUp success";
  //   } else {
  //     return "signUp failed";
  //   }
  // }

  static Future<Response> logout(bool isDeleteDeviceId) async {
    return await Client.get('$apiPath/logout',
        params: {'isDeleteDeviceId': isDeleteDeviceId});
  }

  // static Future<Response> updateSelf(Map<String, dynamic> data) async {
  //   return await Client.post(
  //     'auth/self',
  //     json: data,
  //   );
  // }

  // static Future<Response> sendCode({
  //   RequestCodeType codeType,
  //   String id,
  //   String name,
  //   String phone,
  // }) async {
  //   final json = Map<String, dynamic>.of({
  //     'codeType': codeType.value,
  //     'id': id,
  //     'name': name,
  //     'phone': phone,
  //   });

  //   return await Client.post(
  //     'auth/sendCode',
  //     json: json,
  //   );
  // }

  // static Future<Response> findId({
  //   String objectId,
  //   String code,
  // }) async {
  //   final json = Map<String, dynamic>.of({
  //     'objectId': objectId,
  //     'code': code,
  //   });

  //   return await Client.post(
  //     'auth/find/id',
  //     json: json,
  //   );
  // }

  // static Future<Response> findPassword({
  //   String objectId,
  //   String code,
  //   String password,
  // }) async {
  //   final json = Map<String, dynamic>.of({
  //     'objectId': objectId,
  //     'code': code,
  //     'password': password,
  //   });

  //   return await Client.post(
  //     'auth/find/password',
  //     json: json,
  //   );
  // }

}
