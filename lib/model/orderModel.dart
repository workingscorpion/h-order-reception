import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/menuModel.dart';
import 'package:h_order_reception/utils/localConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderModel.g.dart';

@JsonSerializable()
class OrderModel {
  final String objectId;
  final String roomNumber;
  final String address;
  final String shopName;

  @LocalConverter()
  final DateTime applyTime;
  int status;
  final int amount;
  final List<MenuModel> menus;
  final List<HistoryModel> histories;

  OrderModel({
    this.objectId,
    this.roomNumber,
    this.address,
    this.shopName,
    this.applyTime,
    this.status,
    this.amount,
    this.menus,
    this.histories,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
