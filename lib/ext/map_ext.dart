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
  T? getObject<T>(dynamic key, { T Function(dynamic t)? converter }) {
    if (containsKey(key)) {
      var value = this[key];
      return converter != null? converter(value): value;
    }
    return null;
  }
}