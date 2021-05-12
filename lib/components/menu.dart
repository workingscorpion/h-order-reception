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
          fontSize: 17,
          color: CustomColors.aBlack,
        ),
        child: Container(
          child: ListView(
            children: List.generate(
              menu.length,
              (index) => Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        menu[index].name,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text('${menu[index].count}개'),
                    ),
                    existPrice == true ? Spacer() : Container(),
                    existPrice == true
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