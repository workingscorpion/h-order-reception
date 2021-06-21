import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';

class RefuseDialog extends StatefulWidget {
  RefuseDialog();

  @override
  _RefuseDialogState createState() => _RefuseDialogState();
}

class _RefuseDialogState extends State<RefuseDialog> {
  // static final Map<String, String> reasons = {
  //   'outOfStock': '재고가 모두 소진되었습니다.',
  //   'outOfBusinessTime': '영업시간이 종료되었습니다.',
  //   'deliveryDelayed': '배달이 지연되어 거절되었습니다.',
  //   'requestedByClient': '고객 요청에 따라 거절되었습니다.',
  //   'etc': '',
  // };

  // int selectedIndex;

  // final List<String> statusKey = [
  //   "outOfStock",
  //   "outOfBusinessTime",
  //   "deliveryDelayed",
  //   "requestedByClient",
  //   "etc",
  // ];

  // final List<String> statusValue = [
  //   "재고소진",
  //   "영업종료",
  //   "배달지연",
  //   "고객요청",
  //   "직접입력",
  // ];

  // TextEditingController textEditingController;
  // String selectedKey;

  @override
  void initState() {
    super.initState();

    // textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: BoxConstraints(maxWidth: 500),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(40),
                child: Text(
                  '해당 주문을 거절(취소)\n 하시겠습니까?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['취소', '확인'].map((e) => _button(e)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(String title) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _cancelOrder(title);
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: title == '취소' ? Radius.circular(8) : Radius.zero,
              bottomRight: title == '취소' ? Radius.zero : Radius.circular(8),
            ),
            color: title == '취소'
                ? CustomColors.denyColor
                : CustomColors.tableInnerBorder,
          ),
          child: Text(
            title,
            style: TextStyle(
                color: title == '취소' ? Colors.white : Colors.black,
                fontSize: 20),
          ),
        ),
      ),
    );
  }

  _cancelOrder(title) {
    if (title == '취소') {
      Navigator.of(context).pop();
    } else {}
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Dialog(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: IntrinsicHeight(
  //       child: Container(
  //         width: 800,
  //         padding: EdgeInsets.all(20),
  //         child: Column(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.only(bottom: 5),
  //               child: Text(
  //                 '주문 거절 사유를 선택해주세요',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               margin: EdgeInsets.only(bottom: 0),
  //             ),
  //             Divider(
  //               color: Colors.grey,
  //             ),
  //             _refuse(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

//   _refuse() {
//     return StatefulBuilder(
//       builder: (_context, _setState) {
//         return Builder(
//           builder: (context) {
//             final selectKey = (String key) {
//               selectedKey = key;
//               textEditingController.text = reasons[key];
//               _setState(() {});
//             };

//             return IntrinsicHeight(
//               child: Column(
//                 children: [
//                   Container(height: 12),
//                   Row(
//                     children: List.generate(
//                       statusKey.length,
//                       (index) => _item(
//                           selectKey: selectKey,
//                           text: statusValue[index],
//                           key: statusKey[index],
//                           index: index),
//                     ),
//                   ),
//                   Container(height: 12),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: CustomColors.doneColor,
//                     ),
//                     padding: EdgeInsets.all(15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Container(
//                           child: Text('기타'),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: 15),
//                           padding: EdgeInsets.only(left: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: Colors.white,
//                           ),
//                           child: TextField(
//                             controller: textEditingController,
//                             keyboardType: TextInputType.multiline,
//                             minLines: 10,
//                             maxLines: 10,
//                             decoration: InputDecoration(
//                               hintText: '거절 사유를 적어주세요',
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(height: 12),
//                   Row(
//                     children: [
//                       _button(
//                         onTap: () {
//                           Navigator.of(context).pop();
//                         },
//                         text: '취소',
//                       ),
//                       Container(width: 6),
//                       _button(
//                         onTap: () {
//                           Navigator.of(context).pop(textEditingController.text);
//                         },
//                         text: '확인',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   _button({
//     GestureTapCallback onTap,
//     String text,
//   }) =>
//       Expanded(
//         child: Material(
//           color: text == '확인' ? CustomColors.denyColor : Colors.transparent,
//           borderRadius: BorderRadius.circular(5),
//           clipBehavior: Clip.antiAlias,
//           child: InkWell(
//             onTap: onTap,
//             child: Container(
//               height: 40,
//               padding: EdgeInsets.symmetric(
//                 horizontal: 12,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 border: Border.all(
//                   width: 1,
//                   color: Colors.grey,
//                 ),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color: text == '확인' ? Colors.white : CustomColors.textBlack,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );

//   _item({
//     Function(String key) selectKey,
//     String key,
//     String text,
//     int index,
//   }) =>
//       Expanded(
//         child: Material(
//           color: selectedIndex == index
//               ? CustomColors.waitAcceptColor
//               : CustomColors.doneColor,
//           borderRadius: BorderRadius.circular(5),
//           clipBehavior: Clip.antiAlias,
//           child: InkWell(
//             onTap: () {
//               selectedIndex = index;
//               selectKey(key);
//             },
//             child: Container(
//               height: 40,
//               padding: EdgeInsets.symmetric(
//                 horizontal: 12,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color: selectedIndex == index ? Colors.white : Colors.black,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
}
