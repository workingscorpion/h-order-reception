import 'package:json_annotation/json_annotation.dart';

part 'responseLogin.g.dart';

@JsonSerializable()
class ResponseLogin {
  final String token;
  final String objectId;
  final String identity;
  final String name;
  final String role;

  ResponseLogin({
    this.token,
    this.objectId,
    this.identity,
    this.name,
    this.role,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) =>
      _$ResponseLoginFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLoginToJson(this);
}
