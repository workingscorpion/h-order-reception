// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snapShotModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnapShotModel _$SnapShotModelFromJson(Map<String, dynamic> json) {
  return SnapShotModel(
    objectId: json['objectId'] as String,
    targetType: json['targetType'] as String,
    targetObjectId: json['targetObjectId'] as String,
    data: json['data'] as String,
    createdTime: json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
  );
}

Map<String, dynamic> _$SnapShotModelToJson(SnapShotModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'targetType': instance.targetType,
      'targetObjectId': instance.targetObjectId,
      'data': instance.data,
      'createdTime': instance.createdTime?.toIso8601String(),
    };
