// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updateHistoryStatusModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateHistoryStatusModel _$UpdateHistoryStatusModelFromJson(
    Map<String, dynamic> json) {
  return UpdateHistoryStatusModel(
    status: json['status'] as int,
    data: json['data'] as String,
  );
}

Map<String, dynamic> _$UpdateHistoryStatusModelToJson(
        UpdateHistoryStatusModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
