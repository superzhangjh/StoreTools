extension MapExt on Map<dynamic, dynamic> {
  ///获取数据类型
  List<T>? getList<T>(dynamic key, { T Function(dynamic t)? converter }) {
    var value = this[key];
    if (value is List) {
      List<T> returns = [];
      for (var element in returns) {
        returns.add(converter != null? converter(element): element);
      }
      return returns;
    }
    return null;
  }
}