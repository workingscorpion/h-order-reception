import 'package:h_order_reception/model/jsonGenericConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listModel.g.dart';

@JsonSerializable()
class ListModel<T> {
  final int status;
  final bool result;
  final String message;

  @JsonGenericConverter()
  final List<T> list;

  ListModel({
    this.status,
    this.result,
    this.message,
    this.list,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) =>
      _$ListModelFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ListModelToJson(this);
}

@JsonSerializable()
class ListDataModel<T, T2> {
  final int status;
  final bool result;
  final String message;

  @JsonGenericConverter()
  final List<T> list;

  @JsonGenericConverter()
  final T2 data;

  ListDataModel({
    this.status,
    this.result,
    this.message,
    this.list,
    this.data,
  });

  factory ListDataModel.fromJson(Map<String, dynamic> json) =>
      _$ListDataModelFromJson<T, T2>(json);

  Map<String, dynamic> toJson() => _$ListDataModelToJson(this);
}
