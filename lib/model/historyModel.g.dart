// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) {
  return HistoryModel(
    index: json['index'] as int,
    status: json['status'] as int,
    serviceObjectId: json['serviceObjectId'] as String,
    serviceName: json['serviceName'] as String,
    serviceType: json['serviceType'] as int,
    userObjectId: json['userObjectId'] as String,
    userName: json['userName'] as String,
    deviceObjectId: json['deviceObjectId'] as String,
    deviceName: json['deviceName'] as String,
    data: json['data'] as String,
    amount: json['amount'] as int,
    quantity: json['quantity'] as int,
    menuName: json['menuName'] as String,
    createdTime: const LocalConverter().fromJson(json['createdTime'] as String),
    updatedTime: const LocalConverter().fromJson(json['updatedTime'] as String),
    boundaryName: json['boundaryName'] as String,
  );
}

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'status': instance.status,
      'serviceObjectId': instance.serviceObjectId,
      'serviceName': instance.serviceName,
      'serviceType': instance.serviceType,
      'userObjectId': instance.userObjectId,
      'userName': instance.userName,
      'deviceObjectId': instance.deviceObjectId,
      'deviceName': instance.deviceName,
      'data': instance.data,
      'amount': instance.amount,
      'quantity': instance.quantity,
      'menuName': instance.menuName,
      'createdTime': const LocalConverter().toJson(instance.createdTime),
      'updatedTime': const LocalConverter().toJson(instance.updatedTime),
      'boundaryName': instance.boundaryName,
    };
