// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updateValueModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateValueModel<T> _$UpdateValueModelFromJson<T>(Map<String, dynamic> json) {
  return UpdateValueModel<T>(
    value: JsonGenericConverter<T>().fromJson(json['value']),
  );
}

Map<String, dynamic> _$UpdateValueModelToJson<T>(
        UpdateValueModel<T> instance) =>
    <String, dynamic>{
      'value': JsonGenericConverter<T>().toJson(instance.value),
    };
