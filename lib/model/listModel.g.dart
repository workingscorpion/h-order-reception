// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListModel<T> _$ListModelFromJson<T>(Map<String, dynamic> json) {
  return ListModel<T>(
    total: json['total'] as int,
    list: (json['list'] as List)
        ?.map(JsonGenericConverter<T>().fromJson)
        ?.toList(),
  );
}

Map<String, dynamic> _$ListModelToJson<T>(ListModel<T> instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list?.map(JsonGenericConverter<T>().toJson)?.toList(),
    };

ListDataModel<T, T2> _$ListDataModelFromJson<T, T2>(Map<String, dynamic> json) {
  return ListDataModel<T, T2>(
    total: json['total'] as int,
    list: (json['list'] as List)
        ?.map(JsonGenericConverter<T>().fromJson)
        ?.toList(),
    data: JsonGenericConverter<T2>().fromJson(json['data']),
  );
}

Map<String, dynamic> _$ListDataModelToJson<T, T2>(
        ListDataModel<T, T2> instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list?.map(JsonGenericConverter<T>().toJson)?.toList(),
      'data': JsonGenericConverter<T2>().toJson(instance.data),
    };

ListDataListModel<T, T2> _$ListDataListModelFromJson<T, T2>(
    Map<String, dynamic> json) {
  return ListDataListModel<T, T2>(
    total: json['total'] as int,
    list: (json['list'] as List)
        ?.map(JsonGenericConverter<T>().fromJson)
        ?.toList(),
    data: (json['data'] as List)
        ?.map(JsonGenericConverter<T2>().fromJson)
        ?.toList(),
  );
}

Map<String, dynamic> _$ListDataListModelToJson<T, T2>(
        ListDataListModel<T, T2> instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list?.map(JsonGenericConverter<T>().toJson)?.toList(),
      'data': instance.data?.map(JsonGenericConverter<T2>().toJson)?.toList(),
    };
