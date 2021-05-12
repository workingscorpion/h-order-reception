import 'package:json_annotation/json_annotation.dart';

part 'baseServiceModel.g.dart';

@JsonSerializable()
class BaseServiceModel {
  final String objectId;
  final String name;
  final int type;

  BaseServiceModel({
    this.objectId,
    this.name,
    this.type,
  });

  factory BaseServiceModel.fromJson(Map<String, dynamic> json) =>
      _$BaseServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseServiceModelToJson(this);
}
