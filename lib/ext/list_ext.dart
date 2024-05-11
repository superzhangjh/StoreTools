extension ListExt<T> on List<T>? {
  ///下标安全判断获取List的值
  T? getSafeOfNull(int? index) {
    if (this != null && index != null && index >= 0 && index < this!.length) {
      return this![index];
    }
    return null;
  }

  ///下标安全地设置值
  bool setSafe(int? index, T? element) {
    if (this != null && index != null && index >= 0 && index < this!.length && element != null) {
      this![index] = element;
      return true;
    }
    return false;
  }

  ///下标安全地删除值
  T? removeAtSafe(int? index) {
    if (this != null && index != null && index >= 0 && index < this!.length) {
      return this!.removeAt(index);
    }
    return null;
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

  ///遍历列表，带下标
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

  ///添加或者忽略参数
  addOrIgnore(T? t) {
    if (t != null) {
      this?.add(t);
    }
  }

  ///替换满足条件的第一个
  ///[returns]是否替换成功
  bool replaceWhen(T newElement, bool Function(T element) test) {
    if (this != null) {
      final index = findIndex(test);
      if (this.setSafe(index, newElement)) {
        return true;
      }
    }
    return false;
  }
}