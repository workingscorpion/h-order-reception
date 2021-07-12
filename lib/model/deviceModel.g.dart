// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) {
  return DeviceModel(
    objectId: json['objectId'] as String,
    roomNumber: json['roomNumber'] as int,
    state: json['state'] as int,
    battery: json['battery'] as int,
    isCharging: json['isCharging'] as bool,
    lastLiveTime:
        const LocalConverter().fromJson(json['lastLiveTime'] as String),
  );
}

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'roomNumber': instance.roomNumber,
      'state': instance.state,
      'battery': instance.battery,
      'isCharging': instance.isCharging,
      'lastLiveTime': const LocalConverter().toJson(instance.lastLiveTime),
    };
