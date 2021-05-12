// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListModel<T> _$ListModelFromJson<T>(Map<String, dynamic> json) {
  return ListModel<T>(
    status: json['status'] as int,
    result: json['result'] as bool,
    message: json['message'] as String,
    list: (json['list'] as List)
        ?.map(JsonGenericConverter<T>().fromJson)
        ?.toList(),
  );
}

Map<String, dynamic> _$ListModelToJson<T>(ListModel<T> instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
      'message': instance.message,
      'list': instance.list?.map(JsonGenericConverter<T>().toJson)?.toList(),
    };

ListDataModel<T, T2> _$ListDataModelFromJson<T, T2>(Map<String, dynamic> json) {
  return ListDataModel<T, T2>(
    status: json['status'] as int,
    result: json['result'] as bool,
    message: json['message'] as String,
    list: (json['list'] as List)
        ?.map(JsonGenericConverter<T>().fromJson)
        ?.toList(),
    data: JsonGenericConverter<T2>().fromJson(json['data']),
  );
}

Map<String, dynamic> _$ListDataModelToJson<T, T2>(
        ListDataModel<T, T2> instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result,
      'message': instance.message,
      'list': instance.list?.map(JsonGenericConverter<T>().toJson)?.toList(),
      'data': JsonGenericConverter<T2>().toJson(instance.data),
    };
