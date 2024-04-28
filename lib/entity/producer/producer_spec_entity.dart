import 'package:storetools/entity/base_entity.dart';

class ProducerSpecEntity implements BaseEntity<ProducerSpecEntity> {
  String name = '';

  @override
  ProducerSpecEntity fromJson(Map<String, dynamic> json) => ProducerSpecEntity()
      ..name = name;

  @override
  Map<String, dynamic> toJson() => {
    'name': name
  };
}