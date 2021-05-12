// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) {
  return HistoryModel(
    objectId: json['objectId'] as String,
    orderObjectId: json['orderObjectId'] as String,
    status: json['status'] as int,
    updaterName: json['updaterName'] as String,
    updatedTime: json['updatedTime'] == null
        ? null
        : DateTime.parse(json['updatedTime'] as String),
  );
}

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'orderObjectId': instance.orderObjectId,
      'status': instance.status,
      'updaterName': instance.updaterName,
      'updatedTime': instance.updatedTime?.toIso8601String(),
    };
