import 'package:storetools/entity/base_entity.dart';

///货源具体规格
class ProducerSpecEntity implements BaseEntity<ProducerSpecEntity> {
  String id = '';
  String name = '';

  @override
  ProducerSpecEntity fromJson(Map<String, dynamic> json) => ProducerSpecEntity()
    ..id = json['id']
    ..name = json['name'];

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name
  };
}