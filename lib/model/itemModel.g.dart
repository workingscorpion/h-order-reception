// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return ItemModel(
    objectId: json['objectId'] as String,
    type: json['type'] as int,
    value: json['value'] as String,
    max: json['max'] as int,
    price: json['price'] as int,
    tags: (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : TagModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'objectId': instance.objectId,
      'type': instance.type,
      'value': instance.value,
      'max': instance.max,
      'price': instance.price,
      'tags': instance.tags,
      'items': instance.items,
    };
