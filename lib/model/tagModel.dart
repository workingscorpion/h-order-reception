import 'package:json_annotation/json_annotation.dart';

part 'tagModel.g.dart';

@JsonSerializable()
class TagModel {
  final String key;
  final Map<String, String> metadata;

  TagModel({
    this.key,
    this.metadata,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagModelToJson(this);

  String getMetadata(String key) {
    if (metadata?.isEmpty ?? true) {
      return null;
    }

    return metadata[key];
  }

  bool getMetadataBoolean(String key) {
    return getMetadata(key)?.toLowerCase() == 'true';
  }
}
