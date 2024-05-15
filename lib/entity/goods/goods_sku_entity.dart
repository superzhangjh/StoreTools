import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';

import 'goods_sku_part_entity.dart';

///产品规格
class GoodsSkuEntity extends BaseEntity<GoodsSkuEntity> {
  ///skuid，与电商后台的skuid匹配
  String id = '';
  ///名称
  String name = '';
  ///组成
  List<GoodsSkuPartEntity> parts = [];

  @override
  GoodsSkuEntity fromJson(Map<String, dynamic> json) => GoodsSkuEntity()
    ..id = json.getString('id') ?? ''
    ..name = json.getString('name') ?? ''
    ..parts = json.getList('parts', converter: (e) => GoodsSkuPartEntity().fromJson(e)) ?? [];

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'parts': parts.map((e) => e.toJson()) ?? []
  };
}