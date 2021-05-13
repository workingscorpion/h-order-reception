import 'package:h_order_reception/model/tagModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'itemModel.g.dart';

@JsonSerializable()
class ItemModel {
  final String objectId;
  final int type;
  final String value;
  final int max;
  final int price;
  final List<TagModel> tags;
  final List<ItemModel> items;

  ItemModel({
    this.objectId,
    this.type,
    this.value,
    this.max,
    this.price,
    this.tags,
    this.items,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  TagModel getTag(String key) {
    if (tags?.isEmpty ?? true) {
      return null;
    }

    return tags.singleWhere((t) => t.key == key, orElse: () => null);
  }

  String getTagMetadata(String key, String metadataKey) {
    final tag = getTag(key);
    return tag?.getMetadata(metadataKey);
  }

  bool getTagMetadataBoolean(String key, String metadataKey) {
    final tag = getTag(key);
    return tag?.getMetadataBoolean(metadataKey);
  }
}
