import 'package:json_annotation/json_annotation.dart';

class LocalConverter implements JsonConverter<DateTime, String> {
  const LocalConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json).toLocal();
  }

  @override
  String toJson(DateTime object) {
    return object.toString();
  }
}
