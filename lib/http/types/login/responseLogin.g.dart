// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responseLogin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLogin _$ResponseLoginFromJson(Map<String, dynamic> json) {
  return ResponseLogin(
    token: json['token'] as String,
    objectId: json['objectId'] as String,
    identity: json['identity'] as String,
    name: json['name'] as String,
    role: json['role'] as String,
  );
}

Map<String, dynamic> _$ResponseLoginToJson(ResponseLogin instance) =>
    <String, dynamic>{
      'token': instance.token,
      'objectId': instance.objectId,
      'identity': instance.identity,
      'name': instance.name,
      'role': instance.role,
    };
