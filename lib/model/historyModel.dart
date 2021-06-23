import 'package:json_annotation/json_annotation.dart';

part 'historyModel.g.dart';

@JsonSerializable()
class HistoryModel {
  final int index;
  final int status;
  final String serviceObjectId;
  final String userObjectId;
  final String userName;
  final String deviceObjectId;
  final String deviceName;
  final String data;
  final int amount;
  final int quantity;
  final String menuName;
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
    this.amount,
    this.quantity,
    this.menuName,
    this.createdTime,
    this.updatedTime,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);

  HistoryModel toLocal() {
    return HistoryModel(
      index: index,
      status: status,
      serviceObjectId: serviceObjectId,
      userObjectId: userObjectId,
      userName: userName,
      deviceObjectId: deviceObjectId,
      deviceName: deviceName,
      data: data,
      amount: amount,
      quantity: quantity,
      menuName: menuName,
      createdTime: createdTime?.toLocal(),
      updatedTime: updatedTime?.toLocal(),
    );
  }
}
