import 'package:storetools/api/apis.dart';
import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/ext/map_ext.dart';

import 'goods_producer_sku_binding_entity.dart';

///商品/货源绑定信息
class GoodsProducerBindingEntity extends ApiEntity<GoodsProducerBindingEntity> {
  //商品ID
  String goodsId = '';
  //商品名称
  String goodsName = '';
  //货源id
  String producerId = '';
  //sku绑定信息
  List<GoodsProducerSkuBindingEntity> skuBindings = [];

  GoodsProducerBindingEntity({ bool queryPart = false }) : super(Apis.lcNameGoodsProducerBinding, queryPart);

  @override
  GoodsProducerBindingEntity createFromJson(Map<String, dynamic> json) => GoodsProducerBindingEntity()
    ..goodsId = json.getString('goodsId') ?? ''
    ..goodsName = json.getString('goodsName') ?? ''
    ..producerId = json.getString("producerId") ?? ''
    ..skuBindings = json.getList("skuBindings", converter: (e) => GoodsProducerSkuBindingEntity().fromJson(e))?.toList() ?? [];

  @override
  Map<String, dynamic> convertToJson() => {
    'goodsId': goodsId,
    'goodsName': goodsName,
    'producerId': producerId,
    'skuBindings': skuBindings.map((e) => e.toJson()).toList()
  };

  @override
  List<String>? getQueryPartKeys() => ['goodsId', 'goodsName', 'producerId'];
}