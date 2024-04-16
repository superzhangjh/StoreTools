import 'package:storetools/entity/base_entity.dart';

///Excel读取到的商品行信息（与SKU一一绑定）
class GoodsRowEntity implements BaseEntity<GoodsRowEntity> {
  //第三方的id
  String thirdPartyId = '';
  //名称
  String name = '';
  //skuId
  String skuId = '';
  //sku名称
  String skuName = '';
  //sku图
  String? skuCoverUrl;
  //价格
  double skuPrice = 0;

  @override
  GoodsRowEntity fromJson(Map<String, dynamic> json) {
    var entity = GoodsRowEntity();
    entity.thirdPartyId = json['thirdPartyId'];
    entity.name = json['name'];
    entity.skuId = json['skuId'];
    entity.skuName = json['skuName'];
    entity.skuCoverUrl = json['skuCoverUrl'];
    entity.skuPrice = json['skuPrice'];
    return entity;
  }

  @override
  Map<String, dynamic> toJson() => {
    'thirdPartyId': thirdPartyId,
    'name': name,
    'skuId': skuId,
    'skuName': skuName,
    'skuCoverUrl': skuCoverUrl,
    'skuPrice': skuPrice
  };
}