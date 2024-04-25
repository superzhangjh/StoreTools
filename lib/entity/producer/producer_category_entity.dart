import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/entity/producer/producer_spec_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///分类
class ProducerCategoryEntity implements BaseEntity<ProducerCategoryEntity> {
  String id = '';
  String name = '';
  List<ProducerSpecEntity>? specs;

  @override
  ProducerCategoryEntity fromJson(Map<String, dynamic> json) => ProducerCategoryEntity()
    ..id = json['id']
    ..name = json['name']
    ..specs = json.getList('specs', converter: (e) => ProducerSpecEntity().fromJson(e));

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'specs': specs?.map((e) => e.toJson()).toList()
  };
}