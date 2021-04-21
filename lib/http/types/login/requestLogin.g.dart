// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestLogin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestLogin _$RequestLoginFromJson(Map<String, dynamic> json) {
  return RequestLogin(
    id: json['id'] as String,
    password: json['password'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$RequestLoginToJson(RequestLogin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'password': instance.password,
      'token': instance.token,
    };
