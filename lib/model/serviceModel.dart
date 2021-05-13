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

  Map<String, ItemModel> itemMap([List<ItemModel> list]) {
    if (list == null) {
      list = items;
    }

    final map =
        items.asMap().map((key, value) => MapEntry(value.objectId, value));

    final result = items
        .where((item) => (item.items?.isNotEmpty ?? false))
        .fold<Map<String, ItemModel>>(
            map,
            (previousValue, item) =>
                previousValue..addAll(itemMap(item.items)));

    return result;
  }
}
