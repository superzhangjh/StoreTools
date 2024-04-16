abstract class BaseEntity<E extends BaseEntity<dynamic>> {
  Map<String, dynamic> toJson();

  E fromJson(Map<String, dynamic> json);
}