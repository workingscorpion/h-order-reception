// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _Client implements Client {
  _Client(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<dynamic> login(location) async {
    ArgumentError.checkNotNull(location, 'location');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(location?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request('/v1/auth/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> logout() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request('/v1/auth/logout',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<ListModel<HistoryDetailModel>> historyDetails(status, order) async {
    ArgumentError.checkNotNull(status, 'status');
    ArgumentError.checkNotNull(order, 'order');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/admin/history?filter.order=$order&$status',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ListModel<HistoryDetailModel>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ListModel<HistoryDetailModel>> historyDetail(index) async {
    ArgumentError.checkNotNull(index, 'index');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/admin/history/$index',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ListModel<HistoryDetailModel>.fromJson(_result.data);
    return value;
  }

  @override
  Future<HistoryDetailModel> updateHistoryStatus(index, model) async {
    ArgumentError.checkNotNull(index, 'index');
    ArgumentError.checkNotNull(model, 'model');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(model?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/admin/history/$index/status',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HistoryDetailModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<dynamic> updateUserBoundary() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request('/v1/admin/user/boundary',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<PageModel<HistoryModel>> histories(
      order, status, startTime, endTime) async {
    ArgumentError.checkNotNull(order, 'order');
    ArgumentError.checkNotNull(status, 'status');
    ArgumentError.checkNotNull(startTime, 'startTime');
    ArgumentError.checkNotNull(endTime, 'endTime');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/v1/admin/history/summary?filter.order=$order&$status&filter.startTime=$startTime&filter.endTime=$endTime',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PageModel<HistoryModel>.fromJson(_result.data);
    return value;
  }
}
