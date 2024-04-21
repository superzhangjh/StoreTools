import 'package:storetools/entity/base_entity.dart';

///货源具体规格
class ProducerSpecEntity implements BaseEntity<ProducerSpecEntity> {
  String id = '';
  String name = '';

  @override
  ProducerSpecEntity fromJson(Map<String, dynamic> json) {
    final entity = ProducerSpecEntity();
    entity.id = json['id'];
    entity.name = json['name'];
    return entity;
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name
  };
}