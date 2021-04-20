import 'package:json_annotation/json_annotation.dart';

part 'deviceModel.g.dart';

@JsonSerializable()
class DeviceModel {
  final String objectId;
  final int roomNumber;
  final int state;
  final int battery;
  final bool isCharging;
  final DateTime lastLiveTime;

  DeviceModel({
    this.objectId,
    this.roomNumber,
    this.state,
    this.battery,
    this.isCharging,
    this.lastLiveTime,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
}
