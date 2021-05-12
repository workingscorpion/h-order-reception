import 'package:json_annotation/json_annotation.dart';

part 'historyModel.g.dart';

@JsonSerializable()
class HistoryModel {
  final String objectId;
  final String orderObjectId;
  final int status;
  final String updaterName;
  final DateTime updatedTime;

  HistoryModel({
    this.objectId,
    this.orderObjectId,
    this.status,
    this.updaterName,
    this.updatedTime,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
