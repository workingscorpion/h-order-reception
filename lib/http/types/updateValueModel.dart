import 'package:h_order_reception/model/jsonGenericConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'updateValueModel.g.dart';

@JsonSerializable()
class UpdateValueModel<T> {
  @JsonGenericConverter()
  final T value;

  UpdateValueModel({
    this.value,
  });

  factory UpdateValueModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateValueModelToJson(this);
}
