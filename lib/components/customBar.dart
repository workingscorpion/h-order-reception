import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/store/userInfoStore.dart';

class CustomBar extends StatefulWidget {
  CustomBar({this.index, this.callback});

  final int index;
  final IntCallback callback;

  @override
  _CustomBarState createState() => _CustomBarState();
}

typedef int IntCallback(int val);

class _CustomBarState extends State<CustomBar> {
  final UserInfoStore _userInfoStore = UserInfoStore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: CustomColors.tableOuterBorder, width: 1),
      )),
      child: Row(children: [
        Text('봉보야쥬'),
        Spacer(),
        _logoutButton(),
        Row(
          children: List.generate(2, (index) => _tabButton(index)),
        )
      ]),
    );
  }

  _logoutButton() => Container(
        margin: EdgeInsets.only(right: 10),
        child: RaisedButton(
          onPressed: () {
            _userInfoStore.logout();
          },
          child: Text(
            '로그아웃',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      );

  _tabButton(int index) => GestureDetector(
        onTap: () {
          widget.callback(index);
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: widget.index == index
                ? CustomColors.selectedItemColor
                : Colors.transparent,
          ),
          child: Text(
            '${_tabText(index)}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 30,
                  color: Theme.of(context).textTheme.bodyText2.color,
                ),
          ),
        ),
      );

  _tabText(int index) {
    switch (index) {
      case 0:
        return '접수';
      case 1:
        return '완료';
    }
  }
}
