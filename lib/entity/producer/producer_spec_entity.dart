import 'package:storetools/entity/base/base_local_id_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///货源规格
class ProducerSpecEntity extends BaseLocalIdEntity<ProducerSpecEntity> {
  ///名称
  String name = '';
  ///该规格的价值（元）
  double cost = 0;
  ///标签
  String? tagId;

  @override
  ProducerSpecEntity createFromJson(Map<String, dynamic> json) => ProducerSpecEntity()
    ..name = json.getString('name') ?? ''
    ..cost = json.getDouble('cost') ?? 0
    ..tagId = json.getString('tagId');

  @override
  Map<String, dynamic> convertToJson() => {
    'name': name,
    'cost': cost,
    'tagId': tagId
  };
}