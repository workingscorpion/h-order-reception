import 'package:flutter/material.dart';
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
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Text('lock'),
        ),
      ),
    );
  }
}
