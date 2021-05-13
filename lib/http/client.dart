import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:h_order_reception/http/types/login/requestLoginModel.dart';
import 'package:h_order_reception/http/types/updateHistoryStatusModel.dart';
import 'package:h_order_reception/model/historyDetailModel.dart';
import 'package:h_order_reception/model/listModel.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

const baseUrl = kDebugMode
    ? "http://192.168.0.103:5000/api"
    : "http://jinjoosoft.io:49233/api";

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

  static String token;

  @POST("/v1/auth/login")
  Future login(
    @Body() RequestLoginModel location,
  );

  @POST("/v1/auth/logout")
  Future logout();

  @GET("/v1/admin/history?filter.order={order}&{status}")
  Future<ListModel<HistoryDetailModel>> historyDetails(
    @Path('status') String status,
    @Path('order') String order,
  );

  @GET("/v1/admin/history/{index}")
  Future<ListModel<HistoryDetailModel>> historyDetail(
    @Path('index') int index,
  );

  @POST("/v1/admin/history/{index}/status")
  Future<HistoryDetailModel> updateHistoryStatus(
    @Path('index') int index,
    @Body() UpdateHistoryStatusModel model,
  );
}
