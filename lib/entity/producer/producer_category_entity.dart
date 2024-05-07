import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/entity/producer/producer_spec_entity.dart';
import 'package:storetools/ext/map_ext.dart';

class ProducerCategoryEntity implements BaseEntity<ProducerCategoryEntity> {
  String name = '';
  List<ProducerSpecEntity> specs = [];

  @override
  ProducerCategoryEntity fromJson(Map<String, dynamic> json) => ProducerCategoryEntity()
      ..name = json['name']
      ..specs = json.getList('specs', converter: (e) => ProducerSpecEntity().fromJson(e))?.toList() ?? [];

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'specs': specs.map((e) => e.toJson()).toList()
  };
}