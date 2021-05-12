import 'package:json_annotation/json_annotation.dart';

part 'snapShotModel.g.dart';

@JsonSerializable()
class SnapShotModel {
  final String objectId;
  final String targetType;
  final String targetObjectId;
  final String data;
  final DateTime createdTime;

  SnapShotModel({
    this.objectId,
    this.targetType,
    this.targetObjectId,
    this.data,
    this.createdTime,
  });

  factory SnapShotModel.fromJson(Map<String, dynamic> json) =>
      _$SnapShotModelFromJson(json);

  Map<String, dynamic> toJson() => _$SnapShotModelToJson(this);
}
