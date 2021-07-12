import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/store/historyStore.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/recordModel.dart';

class RefuseDialog extends StatefulWidget {
  RefuseDialog({
    this.historyIndex,
    this.status,
  });

  final int historyIndex;
  final int status;

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

  int selectedIndex;

  final List<String> statusKey = [
    "outOfStock",
    "outOfBusinessTime",
    "deliveryDelayed",
    "requestedByClient",
    "etc",
  ];

  final List<String> statusValue = [
    "재고소진",
    "영업종료",
    "배달지연",
    "고객요청",
    "직접입력",
  ];

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

  RecordModel get historyDetail {
    return HistoryStore.instance.historyDetailMap[widget.historyIndex];
  }

  HistoryModel get history {
    return historyDetail.history;
  }

  @override
  Widget build(BuildContext context) {
    return history.serviceType == 3 ? _shopReject() : _callReject();
  }

  _cancelOrder(bool isOk) async {
    if (!isOk) {
      Navigator.of(context).pop();
    } else {
      HistoryStore.instance.setStatus(
        index: widget.historyIndex,
        status: widget.status == 1 ? -9 : -1,
        message: "주문이 거절되었습니다.",
      );

      Navigator.of(context).pop();
    }
  }

  Widget _callReject() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: BoxConstraints(maxWidth: 400),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(40),
                child: Text(
                  widget.status == 1
                      ? '해당 주문을 거절\n 하시겠습니까?'
                      : '해당 주문을 취소\n 하시겠습니까?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _button(false),
                  _button(true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopReject() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Container(
          width: 800,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  '주문 거절 사유를 선택해주세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                margin: EdgeInsets.only(bottom: 0),
              ),
              Divider(
                color: Colors.grey,
              ),
              _refuse(),
            ],
          ),
        ),
      ),
    );
  }

  _refuse() {
    return StatefulBuilder(
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
                  Container(height: 12),
                  Row(
                    children: List.generate(
                      statusKey.length,
                      (index) => _item(
                          selectKey: selectKey,
                          text: statusValue[index],
                          key: statusKey[index],
                          index: index),
                    ),
                  ),
                  Container(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColors.doneColor,
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child: Text('기타'),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: textEditingController,
                            keyboardType: TextInputType.multiline,
                            minLines: 10,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: '거절 사유를 적어주세요',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 12),
                  Row(
                    children: [
                      _shopButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        text: '취소',
                      ),
                      Container(width: 6),
                      _shopButton(
                        onTap: () {
                          Navigator.of(context).pop(textEditingController.text);
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
    );
  }

  Widget _button(bool isOk) {
    return Expanded(
      child: InkWell(
        onTap: () => _cancelOrder(isOk),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: isOk ? Radius.zero : Radius.circular(8),
              bottomRight: isOk ? Radius.circular(8) : Radius.zero,
            ),
            color:
                isOk ? CustomColors.tableInnerBorder : CustomColors.denyColor,
          ),
          child: Text(
            isOk ? '확인' : '취소',
            style: TextStyle(
              color: isOk ? Colors.black : Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  _shopButton({
    GestureTapCallback onTap,
    String text,
  }) =>
      Expanded(
        child: Material(
          color: text == '확인' ? CustomColors.denyColor : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 40,
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
              child: Text(
                text,
                style: TextStyle(
                  color: text == '확인' ? Colors.white : CustomColors.textBlack,
                ),
              ),
            ),
          ),
        ),
      );

  _item({
    Function(String key) selectKey,
    String key,
    String text,
    int index,
  }) =>
      Expanded(
        child: Material(
          color: selectedIndex == index
              ? CustomColors.waitAcceptColor
              : CustomColors.doneColor,
          borderRadius: BorderRadius.circular(5),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              selectedIndex = index;
              selectKey(key);
            },
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: selectedIndex == index ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
}
