// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) {
  return ServiceModel(
    objectId: json['objectId'] as String,
    name: json['name'] as String,
    type: json['type'] as int,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'name': instance.name,
      'type': instance.type,
      'items': instance.items,
    };
