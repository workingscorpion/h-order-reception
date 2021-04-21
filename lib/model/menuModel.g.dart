// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menuModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuModel _$MenuModelFromJson(Map<String, dynamic> json) {
  return MenuModel(
    objectId: json['objectId'] as String,
    boundaryId: json['boundaryId'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$MenuModelToJson(MenuModel instance) => <String, dynamic>{
      'objectId': instance.objectId,
      'boundaryId': instance.boundaryId,
      'name': instance.name,
      'price': instance.price,
      'count': instance.count,
    };
