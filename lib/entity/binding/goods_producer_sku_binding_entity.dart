import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///商品/货源规格绑定
class GoodsProducerSkuBindingEntity extends BaseEntity<GoodsProducerSkuBindingEntity> {
  ///规格id
  String skuId = '';
  ///货源分类id
  String producerCategoryId = '';
  ///货源规格id
  String producerSpecId = '';

  @override
  GoodsProducerSkuBindingEntity fromJson(Map<String, dynamic> json) => GoodsProducerSkuBindingEntity()
    ..skuId = json.getString("skuId") ?? ''
    ..producerCategoryId = json.getString("producerCategoryId") ?? ''
    ..producerSpecId = json.getString("producerSpecId") ?? '';

  @override
  Map<String, dynamic> toJson() => {
    'skuId': skuId,
    'producerCategoryId': producerCategoryId,
    'producerSpecId': producerSpecId
  };
}