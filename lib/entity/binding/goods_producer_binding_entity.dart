import 'package:storetools/api/apis.dart';
import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/ext/map_ext.dart';

import 'goods_producer_sku_binding_entity.dart';

///商品/货源绑定信息
class GoodsProducerBindingEntity extends ApiEntity<GoodsProducerBindingEntity> {
  String goodsId = '';
  String producerId = '';
  List<GoodsProducerSkuBindingEntity> skuBindings = [];

  GoodsProducerBindingEntity() : super(Apis.lcNameGoodsProducerBinding);

  @override
  GoodsProducerBindingEntity createFromJson(Map<String, dynamic> json) => GoodsProducerBindingEntity()
    ..goodsId = json.getString('goodsId') ?? ''
    ..producerId = json.getString("producerId") ?? ''
    ..skuBindings = json.getList("skuBindings", converter: (e) => GoodsProducerSkuBindingEntity().fromJson(e))?.toList() ?? [];

  @override
  Map<String, dynamic> convertToJson() => {
    'goodsId': goodsId,
    'producerId': producerId,
    'skuBindings': skuBindings.map((e) => e.toJson()).toList()
  };
}