///Excel读取到的商品行信息（与SKU一一绑定）
class GoodsRowEntity {
  //第三方的id
  String thirdPartyId = '';
  //名称
  String name = '';
  //分组名
  String skuGroupName = '';
  //skuId
  String skuId = '';
  //sku名称
  String skuName = '';
  //sku图
  String? skuCoverUrl;
  //价格
  double skuPrice = 0;
}