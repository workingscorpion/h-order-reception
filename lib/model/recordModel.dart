import 'package:h_order_reception/model/historyDetailItemModel.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/snapShotModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recordModel.g.dart';

@JsonSerializable()
class RecordModel {
  HistoryModel history;
  final List<HistoryDetailItemModel> details;
  final SnapShotModel snapShot;

  RecordModel({
    this.history,
    this.details,
    this.snapShot,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) =>
      _$RecordModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecordModelToJson(this);
}
