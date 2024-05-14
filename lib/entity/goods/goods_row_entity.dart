import 'package:storetools/entity/base/base_entity.dart';

///Excel读取到的商品行信息（与SKU一一绑定）
class GoodsRowEntity extends BaseEntity<GoodsRowEntity> {
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
  GoodsRowEntity fromJson(Map<String, dynamic> json) => GoodsRowEntity()
    ..thirdPartyId = json['thirdPartyId']
    ..name = json['name']
    ..skuId = json['skuId']
    ..skuName = json['skuName']
    ..skuCoverUrl = json['skuCoverUrl']
    ..skuPrice = json['skuPrice'];

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