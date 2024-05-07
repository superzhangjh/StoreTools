import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/entity/producer/producer_sku_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///sku运费
class SkuFreightEntity implements BaseEntity<SkuFreightEntity> {
  //额外的运费(会在基础的运费额外加上该运费)
  double extraPrice = 0;
  //规格
  List<ProducerSkuEntity> skus = [];

  @override
  SkuFreightEntity fromJson(Map<String, dynamic> json) => SkuFreightEntity()
    ..extraPrice = json['extraPrice']
    ..skus = json.getList('skus', converter: (e) => ProducerSkuEntity().fromJson(e))?.toList() ?? [];

  @override
  Map<String, dynamic> toJson() => {
    'extraPrice': extraPrice,
    'skus': skus.map((e) => e.toJson()).toList()
  };
}