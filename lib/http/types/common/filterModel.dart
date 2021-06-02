import 'package:json_annotation/json_annotation.dart';

part 'filterModel.g.dart';

@JsonSerializable()
class FilterModel {
  final List<int> status;
  final String order;
  final String startTime;
  final String endTime;

  FilterModel({
    this.status,
    this.order,
    this.startTime,
    this.endTime,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) =>
      _$FilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterModelToJson(this);
}
