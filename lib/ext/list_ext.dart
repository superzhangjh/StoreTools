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

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }
}