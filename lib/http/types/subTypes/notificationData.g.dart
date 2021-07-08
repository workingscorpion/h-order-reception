// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) {
  return NotificationData(
    type: json['type'] as String,
    objectId: json['objectId'] as String,
    data: json['data'] as String,
  );
}

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'objectId': instance.objectId,
      'data': instance.data,
    };
