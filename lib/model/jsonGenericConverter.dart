import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/snapShotModel.dart';
import 'package:json_annotation/json_annotation.dart';

class JsonGenericConverter<T> implements JsonConverter<T, Object> {
  const JsonGenericConverter();

  @override
  T fromJson(Object json) {
    switch (T) {
      case List:
        final list = json as List;
        return list.map((e) => fromJson(e)).toList() as T;
        break;

      case SnapShotModel:
        return SnapShotModel.fromJson(json) as T;
        break;

      case HistoryModel:
        return HistoryModel.fromJson(json) as T;
        break;
    }

    return json as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}
