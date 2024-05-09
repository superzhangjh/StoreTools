import 'package:storetools/utils/log_utils.dart';

extension MapExt on Map<String, dynamic> {
  ///获取数据类型
  List<T>? getList<T>(dynamic key, { T Function(dynamic t)? converter }) {
    var value = this[key];
    if (value is List) {
      List<T> returns = <T>[];
      for (var element in value) {
        var e = element;
        //将Map<dynamic,dynamic>转为Map<String, dynamic>
        if (element is Map) {
          e = element.map((key, value) => MapEntry(key.toString(), value));
        }
        returns.add(converter != null? converter(e): e as T);
      }
      return returns;
    }
    return null;
  }

  ///获取object类型
  T? getObject<T>(dynamic key, { T Function(dynamic)? converter }) {
    if (containsKey(key)) {
      var value = this[key];
      logDebug("类型1111:${value.runtimeType}");
      if (value is Map) {
        logDebug("类型1111执行");
        value = value.map((key, val) => MapEntry(key.toString(), val));
      }
      return converter != null && value != null? converter(value): value;
    }
    return null;
  }

  ///获取double类型
  double? getDouble(dynamic key) {
    if (containsKey(key)) {
      final value = this[key];
      if (value is double) {
        return value;
      } else if (value is String) {
        try {
          return double.parse(value);
        } catch (e) {
          logDebug(e.toString());
        }
      }
    }
    return null;
  }

  String? getString(dynamic key) {
    if (containsKey(key)) {
      final value = this[key];
      return value?.toString();
    }
    return null;
  }

  bool? getBool(dynamic key) {
    if (containsKey(key)) {
      final value = this[key];
      if (value is bool) {
        return value;
      }
      if (value is String) {
        try {
          return bool.parse(value);
        } catch (e) {
          logDebug(e.toString());
        }
      }
    }
    return null;
  }
}