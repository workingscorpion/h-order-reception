import 'package:json_annotation/json_annotation.dart';

part 'requestLoginModel.g.dart';

@JsonSerializable()
class RequestLoginModel {
  String id;
  String password;
  String token;
  String fcmToken;

  RequestLoginModel({
    this.id,
    this.password,
    this.token,
    this.fcmToken,
  });

  factory RequestLoginModel.fromJson(Map<String, dynamic> json) =>
      _$RequestLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestLoginModelToJson(this);
}
