// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) {
  return HistoryModel(
    index: json['index'] as int,
    status: json['status'] as String,
    serviceObjectId: json['serviceObjectId'] as String,
    userObjectId: json['userObjectId'] as String,
    userName: json['userName'] as String,
    deviceObjectId: json['deviceObjectId'] as String,
    deviceName: json['deviceName'] as String,
    data: json['data'] as String,
    createdTime: json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    updatedTime: json['updatedTime'] == null
        ? null
        : DateTime.parse(json['updatedTime'] as String),
  );
}

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'status': instance.status,
      'serviceObjectId': instance.serviceObjectId,
      'userObjectId': instance.userObjectId,
      'userName': instance.userName,
      'deviceObjectId': instance.deviceObjectId,
      'deviceName': instance.deviceName,
      'data': instance.data,
      'createdTime': instance.createdTime?.toIso8601String(),
      'updatedTime': instance.updatedTime?.toIso8601String(),
    };
