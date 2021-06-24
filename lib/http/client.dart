import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:h_order_reception/http/types/login/requestLoginModel.dart';
import 'package:h_order_reception/http/types/updateHistoryStatusModel.dart';
import 'package:h_order_reception/model/recordModel.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/listModel.dart';
import 'package:h_order_reception/model/pageModel.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

const protocol = kDebugMode ? 'http' : 'https';
const host = kDebugMode ? '192.168.0.11:5000' : 'jinjoosoft.io:49233';

@RestApi()
abstract class Client {
  factory Client.create() => _Client(
        Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: token != null
                ? {
                    "Authorization": 'Bearer $token',
                  }
                : {},
          ),
        ),
      );

  static CookieJar cookieJar = CookieJar();

  static get baseUrl {
    return "$protocol://$host/api";
  }

  static get signalRUrl {
    return "$protocol://$host/signal";
  }

  static String token;

  @POST("/v1/auth/login")
  Future login(
    @Body() RequestLoginModel location,
  );

  @POST("/v1/auth/logout")
  Future logout();

  // @GET(
  //     "/v1/admin/history?filter.order={order}&{status}&filter.startTime={startTime}&filter.endTime={endTime}")
  @GET("/v1/admin/history?filter.order={order}&{status}")
  Future<ListModel<RecordModel>> historyDetails(
    @Path('status') String status,
    @Path('order') String order,
    // @Path('startTime') String startTime,
    // @Path('endTime') String endTime,
  );

  @GET("/v1/admin/history/{index}")
  Future<RecordModel> historyDetail(
    @Path('index') String index,
  );

  @POST("/v1/admin/history/{index}/status")
  Future<RecordModel> updateHistoryStatus(
    @Path('index') int index,
    @Body() UpdateHistoryStatusModel model,
  );

  @PUT("/v1/admin/user/boundary")
  Future updateUserBoundary();

  @GET(
      "/v1/admin/history/summary?filter.order={order}&{status}&filter.startTime={startTime}&filter.endTime={endTime}")
  Future<PageModel<HistoryModel>> histories(
    @Path('order') String order,
    @Path('status') String status,
    @Path('startTime') String startTime,
    @Path('endTime') String endTime,
  );
}
