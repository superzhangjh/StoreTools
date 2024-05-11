import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///货源规格
class ProducerSpecEntity extends BaseEntity<ProducerSpecEntity> {
  ///名称
  String name = '';
  ///该规格的价值（元）
  double cost = 0;
  ///标签
  String? tagId;

  @override
  ProducerSpecEntity fromJson(Map<String, dynamic> json) => ProducerSpecEntity()
    ..name = json.getString('name') ?? ''
    ..cost = json.getDouble('cost') ?? 0
    ..tagId = json.getString('tagId');

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'cost': cost,
    'tagId': tagId
  };
}