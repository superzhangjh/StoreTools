import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/entity/goods/goods_sku_spec_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///sku组
class GoodsSkuCategoryEntity extends BaseEntity<GoodsSkuCategoryEntity> {
  String name = '';
  List<GoodsSkuSpecEntity> skuSpecs = [];

  @override
  GoodsSkuCategoryEntity fromJson(Map<String, dynamic> json) => GoodsSkuCategoryEntity()
    ..name = json['name']
    ..skuSpecs = json.getList('skuSpecs', converter: (e) => GoodsSkuSpecEntity().fromJson(e)) ?? [];

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'skuSpecs': skuSpecs.map((e) => e.toJson()).toList()
  };
}