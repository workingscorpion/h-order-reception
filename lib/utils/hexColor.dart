import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  @override
  String toString() {
    final r = red.toRadixString(16);
    final g = green.toRadixString(16);
    final b = blue.toRadixString(16);

    final rr = r.length < 2 ? '0$r' : r;
    final gg = g.length < 2 ? '0$g' : g;
    final bb = b.length < 2 ? '0$b' : b;

    return '#$rr$gg$bb';
  }
}
