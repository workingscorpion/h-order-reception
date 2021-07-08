import 'package:json_annotation/json_annotation.dart';

part 'notificationData.g.dart';

@JsonSerializable()
class NotificationData {
  final String type;
  final String objectId;
  final String data;

  NotificationData({
    this.type,
    this.objectId,
    this.data,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}
