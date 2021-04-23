import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';

class CustomBar extends StatefulWidget {
  CustomBar({
    this.controller,
    this.icons,
  });

  final TabController controller;
  final List<IconData> icons;

  @override
  _CustomBarState createState() => _CustomBarState();
}

class _CustomBarState extends State<CustomBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.tableOuterBorder,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Text(
              '봉보야쥬',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Spacer(),
            Row(
              children: List.generate(
                widget.controller.length,
                (index) => _tabButton(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _tabButton(int index) => Container(
        margin: EdgeInsets.only(left: 12),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            widget.controller.animateTo(index);
          },
          icon: InkWell(
            child: Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Icon(
                widget.icons[index],
                color: widget.controller.index == index
                    ? CustomColors.selectedItemColor
                    : Colors.white,
              ),
            ),
          ),
        ),
      );
}
