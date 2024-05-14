import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///产品规格
class GoodsSkuEntity extends BaseEntity<GoodsSkuEntity> {
  ///skuid，与电商后台的skuid匹配
  String id = '';
  ///名称
  String name = '';

  @override
  GoodsSkuEntity fromJson(Map<String, dynamic> json) => GoodsSkuEntity()
    ..id = json.getString('id') ?? ''
    ..name = json.getString('name') ?? '';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name
  };
}