import 'package:json_annotation/json_annotation.dart';

part 'requestLogin.g.dart';

@JsonSerializable()
class RequestLogin {
  String id;
  String os;
  String password;
  String deviceId;

  RequestLogin({this.id, this.os, this.password, this.deviceId});

  factory RequestLogin.fromJson(Map<String, dynamic> json) =>
      _$RequestLoginFromJson(json);

  Map<String, dynamic> toJson() => _$RequestLoginToJson(this);
}
