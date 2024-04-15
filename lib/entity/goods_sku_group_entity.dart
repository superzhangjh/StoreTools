import 'package:storetools/entity/goods_sku_entity.dart';

///sku组
class GoodsSkuGroupEntity {
  String name = '';
  List<GoodsSkuEntity> skus = [];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'skus': skus
    };
  }
}