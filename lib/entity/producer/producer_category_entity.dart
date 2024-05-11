import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/entity/producer/producer_spec_entity.dart';
import 'package:storetools/entity/producer/producer_tag_entity.dart';
import 'package:storetools/ext/map_ext.dart';

class ProducerCategoryEntity extends BaseEntity<ProducerCategoryEntity> {
  ///名称
  String name = '';
  ///规格
  List<ProducerSpecEntity> specs = [];
  ///标签
  List<ProducerTagEntity>? tags;

  @override
  ProducerCategoryEntity fromJson(Map<String, dynamic> json) => ProducerCategoryEntity()
      ..name = json['name']
      ..specs = json.getList('specs', converter: (e) => ProducerSpecEntity().fromJson(e))?.toList() ?? []
      ..tags = json.getList('tags', converter: (e) => ProducerTagEntity().fromJson(e))?.toList();

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'specs': specs.map((e) => e.toJson()).toList(),
    'tags': tags?.map((e) => e.toJson()).toList()
  };
}