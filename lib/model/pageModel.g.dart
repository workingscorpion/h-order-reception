// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageModel<T> _$PageModelFromJson<T>(Map<String, dynamic> json) {
  return PageModel<T>(
    total: json['total'] as int,
    list: (json['list'] as List)
        ?.map(JsonGenericConverter<T>().fromJson)
        ?.toList(),
  );
}

Map<String, dynamic> _$PageModelToJson<T>(PageModel<T> instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list?.map(JsonGenericConverter<T>().toJson)?.toList(),
    };
