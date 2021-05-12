// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baseServiceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseServiceModel _$BaseServiceModelFromJson(Map<String, dynamic> json) {
  return BaseServiceModel(
    objectId: json['objectId'] as String,
    name: json['name'] as String,
    type: json['type'] as int,
  );
}

Map<String, dynamic> _$BaseServiceModelToJson(BaseServiceModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'name': instance.name,
      'type': instance.type,
    };
