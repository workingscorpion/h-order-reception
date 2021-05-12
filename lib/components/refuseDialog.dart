import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefuseDialog extends StatefulWidget {
  RefuseDialog();

  @override
  _RefuseDialogState createState() => _RefuseDialogState();
}

class _RefuseDialogState extends State<RefuseDialog> {
  String refuseReasonKey;

  Map<String, String> refuseReasonText = {
    'outOfStock': '재고가 모두 소진되었습니다.',
    'outOfBusinessTime': '영업시간이 종료되었습니다.',
    '': '',
    'requestedByClient': '고객 요청에 따라 거절되었습니다.',
    'etc': '',
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('서비스 요청 거절'),
      content: StatefulBuilder(
        builder: (context, setState) {
          final TextEditingController textEditingController =
              TextEditingController();

          final selectKey = (String key) {
            textEditingController.text = refuseReasonText[key];
            setState(() {});
          };

          return IntrinsicHeight(
            child: Column(
              children: [
                Text('거절 사유를 선택해주세요.'),
                Container(height: 12),
                Row(
                  children: [
                    _item(
                      selectKey: selectKey,
                      key: 'outOfStock',
                      text: '재고소진',
                    ),
                    Container(width: 6),
                    _item(
                      selectKey: selectKey,
                      key: 'outOfBusinessTime',
                      text: '영업종료',
                    ),
                    Container(width: 6),
                    _item(
                      selectKey: selectKey,
                      key: '',
                      text: '??',
                    ),
                    Container(width: 6),
                    _item(
                      selectKey: selectKey,
                      key: 'requestedByClient',
                      text: '고객요청',
                    ),
                    Container(width: 6),
                    _item(
                      selectKey: selectKey,
                      key: 'etc',
                      text: '직접입력',
                    ),
                  ],
                ),
                Container(height: 12),
                TextField(
                  controller: textEditingController,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _item({
    Function(String key) selectKey,
    String key,
    String text,
  }) =>
      Expanded(
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              selectKey(key);
            },
            child: Container(
              height: 30,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              alignment: Alignment.center,
              child: Text(text),
            ),
          ),
        ),
      );
}
