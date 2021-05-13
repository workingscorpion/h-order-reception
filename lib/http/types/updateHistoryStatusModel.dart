import 'package:json_annotation/json_annotation.dart';

part 'updateHistoryStatusModel.g.dart';

@JsonSerializable()
class UpdateHistoryStatusModel {
  final int status;
  final String data;

  UpdateHistoryStatusModel({
    this.status,
    this.data,
  });

  factory UpdateHistoryStatusModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateHistoryStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateHistoryStatusModelToJson(this);
}
