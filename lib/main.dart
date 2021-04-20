import 'package:flutter/material.dart';
import 'package:h_order_reception/app.dart';
import 'package:h_order_reception/store/navigationStore.dart';

void main() async {
  runApp(App(
    key: NavigationStore.instance.appKey,
  ));
}
