import 'package:flutter/material.dart';

class Spin extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final Color color;

  Spin({
    this.size = 16,
    this.strokeWidth = 3,
    this.color = Colors.white,
  });

  @override
  _SpinState createState() => _SpinState();
}

class _SpinState extends State<Spin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: CircularProgressIndicator(
        strokeWidth: widget.strokeWidth,
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
      ),
    );
  }
}
