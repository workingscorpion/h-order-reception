import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefuseDialog extends StatefulWidget {
  RefuseDialog();

  @override
  _RefuseDialogState createState() => _RefuseDialogState();
}

class _RefuseDialogState extends State<RefuseDialog> {
  static final Map<String, String> reasons = {
    'outOfStock': '재고가 모두 소진되었습니다.',
    'outOfBusinessTime': '영업시간이 종료되었습니다.',
    'deliveryDelayed': '배달이 지연되어 거절되었습니다.',
    'requestedByClient': '고객 요청에 따라 거절되었습니다.',
    'etc': '',
  };

  TextEditingController textEditingController;
  String selectedKey;

  @override
  void initState() {
    super.initState();

    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('서비스 요청 거절'),
      content: StatefulBuilder(
        builder: (_context, _setState) {
          return Builder(
            builder: (context) {
              final selectKey = (String key) {
                selectedKey = key;
                textEditingController.text = reasons[key];
                _setState(() {});
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
                          key: 'deliveryDelayed',
                          text: '배달지연',
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
                    Container(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _button(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          text: '취소',
                        ),
                        Container(width: 6),
                        _button(
                          onTap: () {
                            Navigator.of(context)
                                .pop(textEditingController.text);
                          },
                          text: '확인',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  _button({
    GestureTapCallback onTap,
    String text,
  }) =>
      Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
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
      );

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
