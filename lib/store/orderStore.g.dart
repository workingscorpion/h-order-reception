// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrderStore on OrderStoreBase, Store {
  final _$ordersAtom = Atom(name: 'OrderStoreBase.orders');

  @override
  List<OrderModel> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(List<OrderModel> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  final _$loadOrdersAsyncAction = AsyncAction('OrderStoreBase.loadOrders');

  @override
  Future loadOrders() {
    return _$loadOrdersAsyncAction.run(() => super.loadOrders());
  }

  @override
  String toString() {
    return '''
orders: ${orders}
    ''';
  }
}
