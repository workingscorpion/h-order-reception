// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryDetailModel _$HistoryDetailModelFromJson(Map<String, dynamic> json) {
  return HistoryDetailModel(
    history: json['history'] == null
        ? null
        : HistoryModel.fromJson(json['history'] as Map<String, dynamic>),
    details: (json['details'] as List)
        ?.map((e) => e == null
            ? null
            : HistoryDetailItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    snapShot: json['snapShot'] == null
        ? null
        : SnapShotModel.fromJson(json['snapShot'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HistoryDetailModelToJson(HistoryDetailModel instance) =>
    <String, dynamic>{
      'history': instance.history,
      'details': instance.details,
      'snapShot': instance.snapShot,
    };
