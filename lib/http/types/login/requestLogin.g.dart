// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestLogin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestLogin _$RequestLoginFromJson(Map<String, dynamic> json) {
  return RequestLogin(
    id: json['id'] as String,
    os: json['os'] as String,
    password: json['password'] as String,
    deviceId: json['deviceId'] as String,
  );
}

Map<String, dynamic> _$RequestLoginToJson(RequestLogin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'os': instance.os,
      'password': instance.password,
      'deviceId': instance.deviceId,
    };
