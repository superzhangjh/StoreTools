import 'goods_sku_group_entity.dart';

class GoodsEntity {
  //id
  String id = '';
  //第三方的id
  String thirdPartyId = '';
  //名称
  String name = '';
  //封面图
  String? coverUrl;
  //sku组
  List<GoodsSkuGroupEntity>? skuGroups;
}
