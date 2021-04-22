import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';

class OrderStatusHelper {
  static Color statusColor(int status) {
    switch (status) {
      case 0:
        return CustomColors.waitAcceptColor;
      case 1:
        return CustomColors.itemReadyColor;
      case 2:
        return CustomColors.deleveryReadColor;
      case 3:
        return CustomColors.deleveringColor;
      case 4:
        return CustomColors.doneColor;
      default:
        return CustomColors.waitAcceptColor;
    }
  }

  static String statusText(int status) {
    switch (status) {
      case 0:
        return '수락 대기';
      case 1:
        return '상품 준비';
      case 2:
        return '배달 준비 중';
      case 3:
        return '배달 중';
      case 4:
        return '완료';
      default:
        return '수락 대기';
    }
  }
}
