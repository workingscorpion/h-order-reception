import 'package:json_annotation/json_annotation.dart';

part 'historyModel.g.dart';

@JsonSerializable()
class HistoryModel {
  final int index;
  final String status;
  final String serviceObjectId;
  final String userObjectId;
  final String userName;
  final String deviceObjectId;
  final String deviceName;
  final String data;
  final DateTime createdTime;
  final DateTime updatedTime;

  HistoryModel({
    this.index,
    this.status,
    this.serviceObjectId,
    this.userObjectId,
    this.userName,
    this.deviceObjectId,
    this.deviceName,
    this.data,
    this.createdTime,
    this.updatedTime,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
