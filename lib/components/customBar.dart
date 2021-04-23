import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/store/userInfoStore.dart';

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
  final UserInfoStore _userInfoStore = UserInfoStore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: CustomColors.tableOuterBorder, width: 1),
      )),
      child: Row(children: [
        Text('봉보야쥬'),
        Spacer(),
        _logoutButton(),
        Row(
          children: List.generate(
            3,
            (index) => _tabButton(index),
          ),
        )
      ]),
    );
  }

  _logoutButton() => Container(
        margin: EdgeInsets.only(right: 10),
        child: Material(
          child: InkWell(
            onTap: () {
              _userInfoStore.logout();
            },
            child: Text(
              '로그아웃',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      );

  _tabButton(int index) => Container(
        margin: EdgeInsets.only(right: 10),
        child: Material(
          color: widget.controller.index == index
              ? CustomColors.selectedItemColor
              : Colors.transparent,
          child: InkWell(
            onTap: () {
              widget.controller.animateTo(index);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Icon(
                widget.icons[index],
                color: widget.controller.index == index
                    ? Colors.white
                    : CustomColors.selectedItemColor,
              ),
            ),
          ),
        ),
      );
}
