import 'package:json_annotation/json_annotation.dart';

part 'serviceModel.g.dart';

@JsonSerializable()
class ServiceModel {
  final String objectId;
  final String name;
  final int type;

  ServiceModel({
    this.objectId,
    this.name,
    this.type,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
