import 'package:h_order_reception/model/itemModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'serviceModel.g.dart';

@JsonSerializable()
class ServiceModel {
  final String objectId;
  final String name;
  final int type;
  final List<ItemModel> items;

  ServiceModel({
    this.objectId,
    this.name,
    this.type,
    this.items,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);

  Map<String, ItemModel> itemMap() {
    return _itemMap(items);
  }

  Map<String, ItemModel> _itemMap(List<ItemModel> list) {
    final result =
        list.asMap().map((key, value) => MapEntry(value.objectId, value));

    final subItems = list.where((item) => (item.items?.isNotEmpty ?? false));

    if (subItems?.isNotEmpty ?? false) {
      subItems.map<Map<String, ItemModel>>((item) => _itemMap(item.items))
        ..forEach((element) {
          result..addAll(element);
        });
    }

    return result;
  }
}
