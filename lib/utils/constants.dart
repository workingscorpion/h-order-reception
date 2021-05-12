import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';

const String NotificationChannelId = 'hOrderId';
const String NotificationChannelName = 'hOrderChannel';
const String NotificationChannelDescription = 'hOrder notification';

final Map<int, OrderStatusModel> orderStatus = {
  -1: OrderStatusModel(
    name: '취소',
    color: CustomColors.doneColor,
  ),
  -9: OrderStatusModel(
    name: '거절',
    color: CustomColors.doneColor,
  ),
  1: OrderStatusModel(
    name: '수락대기',
    color: CustomColors.doneColor,
  ),
  2: OrderStatusModel(
    name: '준비중',
    color: CustomColors.doneColor,
  ),
  3: OrderStatusModel(
    name: '배달 준비중',
    color: CustomColors.doneColor,
  ),
  4: OrderStatusModel(
    name: '배달중',
    color: CustomColors.doneColor,
  ),
  9: OrderStatusModel(
    name: '완료',
    color: CustomColors.doneColor,
  ),

  // '상품 준비',
  // '배달 준비 중',
  // '배달 중',
  // '완료',
};

class OrderStatusModel {
  final String name;
  final Color color;

  OrderStatusModel({
    this.name,
    this.color,
  });
}
