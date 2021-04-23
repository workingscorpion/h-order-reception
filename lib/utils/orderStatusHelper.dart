import 'package:h_order_reception/constants/customColors.dart';

class OrderStatusHelper {
  static const statusColor = [
    CustomColors.waitAcceptColor,
    CustomColors.itemReadyColor,
    CustomColors.deleveryReadColor,
    CustomColors.deleveringColor,
    CustomColors.doneColor,
  ];

  static const statusText = [
    '수락 대기',
    '상품 준비',
    '배달 준비 중',
    '배달 중',
    '완료',
  ];
}
