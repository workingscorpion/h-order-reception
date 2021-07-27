// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestLoginModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestLoginModel _$RequestLoginModelFromJson(Map<String, dynamic> json) {
  return RequestLoginModel(
    id: json['id'] as String,
    password: json['password'] as String,
    token: json['token'] as String,
    fcmToken: json['fcmToken'] as String,
  );
}

Map<String, dynamic> _$RequestLoginModelToJson(RequestLoginModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'password': instance.password,
      'token': instance.token,
      'fcmToken': instance.fcmToken,
    };
