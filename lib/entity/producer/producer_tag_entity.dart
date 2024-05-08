import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///货源标签（用于特殊逻辑处理）
class ProducerTagEntity extends BaseEntity<ProducerTagEntity> {
  String id = '';
  String name = '';

  @override
  ProducerTagEntity fromJson(Map<String, dynamic> json) => ProducerTagEntity()
    ..id = json.getString('id') ?? ''
    ..name = json.getString('name') ?? '';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name
  };
}