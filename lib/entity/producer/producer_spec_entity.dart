import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/entity/base/base_with_id_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///货源规格
class ProducerSpecEntity extends BaseWithIdEntity<ProducerSpecEntity> {
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
  void fillToJson(Map<String, dynamic> json) {
    json['name'] = name;
    json['cost'] = cost;
    json['tagId'] = tagId;
  }
}