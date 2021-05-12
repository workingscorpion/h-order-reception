import 'package:dio/dio.dart';
import 'package:h_order_reception/http/types/login/requestLoginModel.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/listModel.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: "http://192.168.0.104:5000/api")
abstract class Client {
  factory Client.create() => _Client(Dio());

  @POST("/v1/auth/login")
  Future login(
    @Body() RequestLoginModel location,
  );

  @POST("/v1/auth/logout")
  Future logout();

  @POST("/v1/admin/history")
  Future<ListDataModel<HistoryModel, Map>> histories();
}
