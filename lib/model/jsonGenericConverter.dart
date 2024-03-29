import 'package:h_order_reception/model/recordModel.dart';
import 'package:h_order_reception/model/historyModel.dart';
import 'package:h_order_reception/model/itemModel.dart';
import 'package:h_order_reception/model/serviceModel.dart';
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

      case SnapShotModel:
        return SnapShotModel.fromJson(json) as T;

      case ServiceModel:
        return ServiceModel.fromJson(json) as T;

      case ItemModel:
        return ItemModel.fromJson(json) as T;

      case HistoryModel:
        return HistoryModel.fromJson(json) as T;

      case RecordModel:
        return RecordModel.fromJson(json) as T;
    }

    return json as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}
