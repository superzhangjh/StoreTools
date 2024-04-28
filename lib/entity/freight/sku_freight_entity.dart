import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/entity/producer/producer_sku_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///sku运费
class SkuFreightEntity implements BaseEntity<SkuFreightEntity> {
  //运费
  double price = 0;
  //规格
  List<ProducerSkuEntity> skus = [];

  @override
  SkuFreightEntity fromJson(Map<String, dynamic> json) => SkuFreightEntity()
    ..price = json['price']
    ..skus = json.getList('skus', converter: (e) => ProducerSkuEntity().fromJson(e))?.toList() ?? [];

  @override
  Map<String, dynamic> toJson() => {
    'price': price,
    'skus': skus.map((e) => e.toJson()).toList()
  };
}