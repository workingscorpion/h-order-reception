import 'package:h_order_reception/utils/localConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'historyModel.g.dart';

@JsonSerializable()
class HistoryModel {
  final int index;
  final int status;
  final String serviceObjectId;
  final String serviceName;
  final int serviceType;
  final String userObjectId;
  final String userName;
  final String deviceObjectId;
  final String deviceName;
  final String data;
  final int amount;
  final int quantity;
  final String menuName;

  @LocalConverter()
  final DateTime createdTime;

  @LocalConverter()
  final DateTime updatedTime;
  final String boundaryName;

  HistoryModel({
    this.index,
    this.status,
    this.serviceObjectId,
    this.serviceName,
    this.serviceType,
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
    this.boundaryName,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
