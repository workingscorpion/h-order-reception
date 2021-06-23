import 'package:h_order_reception/model/jsonGenericConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listModel.g.dart';

@JsonSerializable()
class ListModel<T> {
  final int total;

  @JsonGenericConverter()
  final List<T> list;

  ListModel({
    this.total,
    this.list,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) =>
      _$ListModelFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ListModelToJson(this);
}

@JsonSerializable()
class ListDataModel<T, T2> extends ListModel<T> {
  @JsonGenericConverter()
  final T2 data;

  ListDataModel({
    int total,
    List<T> list,
    this.data,
  }) : super(
          total: total,
          list: list,
        );

  factory ListDataModel.fromJson(Map<String, dynamic> json) =>
      _$ListDataModelFromJson<T, T2>(json);

  Map<String, dynamic> toJson() => _$ListDataModelToJson(this);
}

@JsonSerializable()
class ListDataListModel<T, T2> extends ListModel<T> {
  @JsonGenericConverter()
  final List<T2> data;

  ListDataListModel({
    int total,
    List<T> list,
    this.data,
  }) : super(
          total: total,
          list: list,
        );

  factory ListDataListModel.fromJson(Map<String, dynamic> json) =>
      _$ListDataListModelFromJson<T, T2>(json);

  Map<String, dynamic> toJson() => _$ListDataListModelToJson(this);
}
