abstract class BaseEntity<E extends BaseEntity<dynamic>> {
  Map<String, dynamic> toJson();

  E fromJson(Map<String, dynamic> json);

  ///拷贝当前对象
  E copy() {
    return fromJson(toJson());
  }
}