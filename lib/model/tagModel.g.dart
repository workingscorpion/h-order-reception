// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return TagModel(
    key: json['key'] as String,
    metadata: (json['metadata'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      'key': instance.key,
      'metadata': instance.metadata,
    };
