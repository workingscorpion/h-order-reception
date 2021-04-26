import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/model/menuModel.dart';
import 'package:intl/intl.dart';

class Menu extends StatelessWidget {
  Menu({this.menu, this.existPrice});

  final List<MenuModel> menu;
  final bool existPrice;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 20,
          color: CustomColors.aBlack,
        ),
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: List.generate(
              menu.length,
              (index) => Container(
                child: Row(
                  children: [
                    Text(menu[index].name),
                    Spacer(),
                    Text('${menu[index].count}개'),
                    existPrice != null ? Spacer() : Container(),
                    existPrice != null
                        ? Text(
                            '${NumberFormat().format(menu[index].price * menu[index].count)}원')
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
