import 'package:json_annotation/json_annotation.dart';

part 'historyDetailItemModel.g.dart';

@JsonSerializable()
class HistoryDetailItemModel {
  final int index;
  final int historyIndex;
  final int status;
  final String data;
  final DateTime createdTime;
  final DateTime updatedTime;

  final String userObjectId;
  final String userName;

  final String deviceObjectId;
  final String deviceName;

  HistoryDetailItemModel({
    this.index,
    this.historyIndex,
    this.status,
    this.data,
    this.createdTime,
    this.updatedTime,
    this.userObjectId,
    this.userName,
    this.deviceObjectId,
    this.deviceName,
  });

  factory HistoryDetailItemModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryDetailItemModelToJson(this);
}
