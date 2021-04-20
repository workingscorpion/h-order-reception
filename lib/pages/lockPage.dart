import 'package:flutter/material.dart';
import 'package:h_order_reception/components/gradientClock.dart';
import 'package:h_order_reception/store/navigationStore.dart';

class LockPage extends StatelessWidget {
  const LockPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigationStore.instance.appKey.currentState.resetSetMain();
        return true;
      },
      child: GestureDetector(
        onPanDown: (event) {
          Navigator.of(context).pop();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: GradientClock(
              startColor: Color.fromRGBO(185, 235, 201, 1),
              endColor: Color.fromRGBO(52, 152, 219, 1),
            ),
          ),
        ),
      ),
    );
  }
}
