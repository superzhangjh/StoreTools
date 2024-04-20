extension ListExt<T> on List<T> {
  ///下标安全判断获取List的值
  T? getSafeOfNull(int? index) {
    if (index != null && index >= 0 && index < length) {
      return this[index];
    }
    return null;
  }

  T? find(bool Function(T element) test) {
    for (var e in this) {
      if (test(e)) {
        return e;
      }
    }
    return null;
  }
}