import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/entity/goods_sku_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///sku组
class GoodsSkuGroupEntity implements BaseEntity<GoodsSkuGroupEntity> {
  String name = '';
  List<GoodsSkuEntity> skus = [];

  @override
  GoodsSkuGroupEntity fromJson(Map<String, dynamic> json) {
    final entity = GoodsSkuGroupEntity();
    entity.name = json['name'];
    entity.skus = json.getList('skus', converter: (e) => GoodsSkuEntity().fromJson(e)) ?? [];
    return entity;
  }

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'skus': skus.map((e) => e.toJson()).toList()
  };
}