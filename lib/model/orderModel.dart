import 'package:h_order_reception/model/menuModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderModel.g.dart';

@JsonSerializable()
class OrderModel {
  final String objectId;
  final String roomNumber;
  final String address;
  final String shopName;
  final DateTime applyTime;
  final int status;
  final int amount;
  final List<MenuModel> menus;

  OrderModel({
    this.objectId,
    this.roomNumber,
    this.address,
    this.shopName,
    this.applyTime,
    this.status,
    this.amount,
    this.menus,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
