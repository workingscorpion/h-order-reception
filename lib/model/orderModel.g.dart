// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    objectId: json['objectId'] as String,
    roomNumber: json['roomNumber'] as String,
    shopName: json['shopName'] as String,
    applyTime: json['applyTime'] == null
        ? null
        : DateTime.parse(json['applyTime'] as String),
    status: json['status'] as int,
    amount: json['amount'] as int,
    menus: (json['menus'] as List)
        ?.map((e) =>
            e == null ? null : MenuModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'roomNumber': instance.roomNumber,
      'shopName': instance.shopName,
      'applyTime': instance.applyTime?.toIso8601String(),
      'status': instance.status,
      'amount': instance.amount,
      'menus': instance.menus,
    };
