import 'package:json_annotation/json_annotation.dart';

part 'requestLogin.g.dart';

@JsonSerializable()
class RequestLogin {
  String id;
  String password;
  String token;

  RequestLogin({
    this.id,
    this.password,
    this.token,
  });

  factory RequestLogin.fromJson(Map<String, dynamic> json) =>
      _$RequestLoginFromJson(json);

  Map<String, dynamic> toJson() => _$RequestLoginToJson(this);
}
