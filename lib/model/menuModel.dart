import 'package:json_annotation/json_annotation.dart';

part 'menuModel.g.dart';

@JsonSerializable()
class MenuModel {
  final String objectId;
  final String boundaryId;
  final String name;
  final int price;
  final int count;

  MenuModel({
    this.objectId,
    this.boundaryId,
    this.name,
    this.price,
    this.count,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuModelToJson(this);
}
