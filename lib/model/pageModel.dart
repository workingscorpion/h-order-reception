import 'package:h_order_reception/model/jsonGenericConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pageModel.g.dart';

@JsonSerializable()
class PageModel<T> {
  final int total;

  @JsonGenericConverter()
  final List<T> list;

  PageModel({
    this.total,
    this.list,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) =>
      _$PageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageModelToJson(this);
}
