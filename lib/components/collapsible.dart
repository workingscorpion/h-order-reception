import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';

class Collapsible extends StatefulWidget {
  final Widget header;
  final Widget body;

  Collapsible({
    this.header,
    this.body,
  });

  @override
  _CollapsibleState createState() => _CollapsibleState();
}

class _CollapsibleState extends State<Collapsible> {
  bool collapsed = true;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          collapsed = !collapsed;
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: CustomColors.tableInnerBorder,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: collapsed ? Colors.white : Colors.black.withOpacity(.05),
                child: widget.header,
              ),
              collapsed ? Container() : widget.body ?? Container(),
            ],
          ),
        ),
      );
}
