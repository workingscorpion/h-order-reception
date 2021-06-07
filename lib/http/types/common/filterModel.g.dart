// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) {
  return FilterModel(
    status: (json['status'] as List)?.map((e) => e as int)?.toList(),
    order: json['order'] as String,
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
  );
}

Map<String, dynamic> _$FilterModelToJson(FilterModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'order': instance.order,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
