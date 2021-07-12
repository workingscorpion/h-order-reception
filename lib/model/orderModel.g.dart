// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    objectId: json['objectId'] as String,
    roomNumber: json['roomNumber'] as String,
    address: json['address'] as String,
    shopName: json['shopName'] as String,
    applyTime: const LocalConverter().fromJson(json['applyTime'] as String),
    status: json['status'] as int,
    amount: json['amount'] as int,
    menus: (json['menus'] as List)
        ?.map((e) =>
            e == null ? null : MenuModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    histories: (json['histories'] as List)
        ?.map((e) =>
            e == null ? null : HistoryModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'roomNumber': instance.roomNumber,
      'address': instance.address,
      'shopName': instance.shopName,
      'applyTime': const LocalConverter().toJson(instance.applyTime),
      'status': instance.status,
      'amount': instance.amount,
      'menus': instance.menus,
      'histories': instance.histories,
    };
