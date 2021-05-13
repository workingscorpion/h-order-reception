import 'package:h_order_reception/model/historyDetailItemModel.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/snapShotModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'historyDetailModel.g.dart';

@JsonSerializable()
class HistoryDetailModel {
  final HistoryModel history;
  final List<HistoryDetailItemModel> details;
  final SnapShotModel snapShot;

  HistoryDetailModel({
    this.history,
    this.details,
    this.snapShot,
  });

  factory HistoryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryDetailModelToJson(this);
}
