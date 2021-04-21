import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';

const protocol = kDebugMode ? 'http' : 'https';
const host = kDebugMode ? 'localhost:5000' : 'localhost:5000';

// const baseImageUrl =
//     'https://rumyr3-test-files.s3.ap-northeast-2.amazonaws.com/';

class Client {
  static CookieJar cookieJar = CookieJar();
  static String hotelUrl = '';

  static Dio client() {
    Dio dio = Dio(BaseOptions(
      contentType: ContentType.json.toString(),
    ));

    dio.interceptors.add(CookieManager(cookieJar));

    return dio;
  }

  static get baseUrl {
    if ((hotelUrl?.length ?? 0) > 0) {
      return '$protocol://$hotelUrl.$host/api/';
    } else {
      return '$protocol://$host/api/';
    }
  }

  static get signalRUrl {
    if ((hotelUrl?.length ?? 0) > 0) {
      return '$protocol://$hotelUrl.$host/notification';
    } else {
      return '$protocol://$host/notification';
    }
  }

  static Future<Response> get(String path,
      {Map<String, dynamic> params}) async {
    try {
      return await client().get(
        '$baseUrl$path',
        queryParameters: params,
      );
    } on DioError catch (error) {
      throw _error(error);
    }
  }

  static Future<Response> post(String path, {Map<String, dynamic> json}) async {
    try {
      return await client().post(
        '$baseUrl$path',
        data: json,
      );
    } on DioError catch (error) {
      throw _error(error);
    }
  }

  static Future<Response> postFormData(String path, FormData formData) async {
    try {
      return await client().post(
        '$baseUrl$path',
        data: formData,
      );
    } on DioError catch (error) {
      throw _error(error);
    }
  }

  static Future<Response> put(String path, {Map<String, dynamic> json}) async {
    try {
      return await client().put(
        '$baseUrl$path',
        data: json,
      );
    } on DioError catch (error) {
      throw _error(error);
    }
  }

  static Future<Response> putFormData(String path, FormData formData) async {
    try {
      return await client().put(
        '$baseUrl$path',
        data: formData,
      );
    } on DioError catch (error) {
      throw _error(error);
    }
  }

  static Future<Response> delete(String path,
      {Map<String, dynamic> json}) async {
    try {
      return await client().delete(
        '$baseUrl$path',
        data: json,
      );
    } on DioError catch (error) {
      throw _error(error);
    }
  }

  static _error(DioError error) {
    return error;
  }
}
