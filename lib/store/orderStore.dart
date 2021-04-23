import 'dart:async';
import 'package:h_order_reception/model/orderModel.dart';
import 'package:h_order_reception/utils/lazy.dart';
import 'package:mobx/mobx.dart';

part 'orderStore.g.dart';

class OrderStore extends OrderStoreBase with _$OrderStore {
  static final Lazy<OrderStore> _lazy =
      Lazy<OrderStore>(() => new OrderStore());

  static OrderStore get instance => _lazy.value;
}

abstract class OrderStoreBase with Store {
  @observable
  List<OrderModel> orders = List();

  @action
  loadOrders() async {}
}
