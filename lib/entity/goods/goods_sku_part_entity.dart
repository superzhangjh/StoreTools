import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///sku的名称组成
class GoodsSkuPartEntity extends BaseEntity<GoodsSkuPartEntity> {
  ///分类名
  String category = '';
  ///组成名
  String name = '';

  @override
  GoodsSkuPartEntity fromJson(Map<String, dynamic> json) => GoodsSkuPartEntity()
    ..category = json.getString('category') ?? ''
    ..name = json.getString('name') ?? '';

  @override
  Map<String, dynamic> toJson() => {
    'category': category,
    'name': name
  };
}