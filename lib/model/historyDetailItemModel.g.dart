// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyDetailItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryDetailItemModel _$HistoryDetailItemModelFromJson(
    Map<String, dynamic> json) {
  return HistoryDetailItemModel(
    index: json['index'] as int,
    historyIndex: json['historyIndex'] as int,
    status: json['status'] as int,
    data: json['data'] as String,
    createdTime: const LocalConverter().fromJson(json['createdTime'] as String),
    updatedTime: const LocalConverter().fromJson(json['updatedTime'] as String),
    userObjectId: json['userObjectId'] as String,
    userName: json['userName'] as String,
    deviceObjectId: json['deviceObjectId'] as String,
    deviceName: json['deviceName'] as String,
  );
}

Map<String, dynamic> _$HistoryDetailItemModelToJson(
        HistoryDetailItemModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'historyIndex': instance.historyIndex,
      'status': instance.status,
      'data': instance.data,
      'createdTime': const LocalConverter().toJson(instance.createdTime),
      'updatedTime': const LocalConverter().toJson(instance.updatedTime),
      'userObjectId': instance.userObjectId,
      'userName': instance.userName,
      'deviceObjectId': instance.deviceObjectId,
      'deviceName': instance.deviceName,
    };
