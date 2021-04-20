import 'package:flutter/material.dart';

mixin SnackBarHelper<T extends StatefulWidget> on State<T> {
  ScaffoldFeatureController _snackBar;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  showSnackBar(String message) async {
    if (_snackBar != null) {
      _snackBar.close();
      _snackBar = null;
    }

    _snackBar = scaffoldKey.currentState.showSnackBar(SnackBar(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      content: Container(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    ));
  }
}
