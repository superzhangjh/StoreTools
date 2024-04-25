extension ListExt<T> on List<T>? {
  ///下标安全判断获取List的值
  T? getSafeOfNull(int? index) {
    if (this != null && index != null && index >= 0 && index < this!.length) {
      return this![index];
    }
    return null;
  }

  ///下标安全地设置值
  bool setSafe(int index, T element) {
    if (this != null && index >= 0 && index < this!.length) {
      this![index] = element;
      return true;
    }
    return false;
  }

  ///查找满足条件的元素
  T? find(bool Function(T element) test) {
    if (this != null) {
      for (var e in this!) {
        if (test(e)) {
          return e;
        }
      }
    }
    return null;
  }

  ///查找满足条件的元素
  T? findWithIndex(bool Function(T element, int index) test) {
    if (this != null) {
      for (var i=0; i<this!.length; i++) {
        final element = this![i];
        if (test(element, i)) {
          return element;
        }
      }
    }
    return null;
  }

  ///查找满足条件的下标
  int findIndex(bool Function(T element) test) {
    if (this != null) {
      for (var i=0; i<this!.length; i++) {
        var element = this![i];
        if (test(element)) {
          return i;
        }
      }
    }
    return -1;
  }

  ///列表是否空数据
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  ///筛选数据
  List<T>? filter(bool Function(T element) test) {
    List<T>? list;
    if (this != null) {
      for (var e in this!) {
        if (test(e)) {
          list ??= <T>[];
          list.add(e);
        }
      }
    }
    return list;
  }

  List<E>? mapIndex<E>(E Function(int index, T element) toElement) {
    List<E>? result;
    if (this != null) {
      for (int i = 0; i < this!.length; i++) {
        result ??= [];
        result.add(toElement(i, this![i]));
      }
    }
    return result;
  }
}