import 'package:storetools/api/apis.dart';
import 'package:storetools/entity/goods/goods_sku_spec_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ext/map_ext.dart';

import '../../api/entity/api_entity.dart';
import 'goods_row_entity.dart';
import 'goods_sku_category_entity.dart';
import 'goods_sku_entity.dart';

class GoodsEntity extends ApiEntity<GoodsEntity> {
  //第三方的id
  String thirdPartyId = '';
  //店铺id
  String shopId = '';
  //名称
  String name = '';
  //封面图
  String? coverUrl;
  //sku组
  List<GoodsSkuCategoryEntity> skuCategories = [];
  //货源绑定id
  List<String> producerBindingIds = [];
  //sku信息
  List<GoodsSkuEntity> skus = [];

  GoodsEntity(): super(Apis.lcNameGoods);

  @override
  Map<String, dynamic> convertToJson() => {
    'thirdPartyId': thirdPartyId,
    'shopId': shopId,
    'name': name,
    'coverUrl': coverUrl,
    'skuCategories': skuCategories.map((e) => e.toJson()).toList(),
    'producerBindingIds': producerBindingIds,
    'skus': skus.map((e) => e.toJson()).toList()
  };

  @override
  GoodsEntity createFromJson(Map<String, dynamic> json) => GoodsEntity()
    ..thirdPartyId = json['thirdPartyId']
    ..shopId = json['shopId']
    ..name = json['name']
    ..coverUrl = json['coverUrl']
    ..skuCategories = json.getList('skuCategories', converter: (e) => GoodsSkuCategoryEntity().fromJson(e)) ?? []
    ..producerBindingIds = json.getList('producerBindingIds') ?? []
    ..skus = json.getList("skus", converter: (e) => GoodsSkuEntity().fromJson(e)) ?? [];

  ///将行数据转为商品数据，合并多个sku为一个商品
  ///[shopId]店铺id
  static List<GoodsEntity>? fromRows(List<GoodsRowEntity>? rowEntities, String? shopId) {
    if (rowEntities == null || rowEntities.isEmpty) return null;
    List<GoodsEntity> goodsList = [];
    Map<String, GoodsEntity?> goodsMap = {};
    for (var element in rowEntities) {
      var id = element.thirdPartyId;
      var goodsEntity = goodsMap[id];
      if (goodsEntity == null) {
        //创建商品
        goodsEntity = GoodsEntity();
        goodsEntity.shopId = shopId ?? "";
        goodsEntity.thirdPartyId = element.thirdPartyId;
        goodsEntity.name = element.name;
        goodsEntity.coverUrl = element.skuCoverUrl;
        //添加商品到数组内
        goodsList.add(goodsEntity);
      }
      goodsEntity._pushSku(element.skuId, element.skuName, element.skuCoverUrl, element.skuPrice);
      goodsMap[id] = goodsEntity;
    }
    return goodsList;
  }

  ///解析sku
  _pushSku(String skuId, String skuInfo, String? coverUrl, double price) {
    Map<String, String>? infoMap = _parseSku(skuInfo);
    if (infoMap == null) return;
    for (var entry in infoMap.entries) {
      //查找名称相同的sku分组
      var skuCategory = skuCategories.find((element) => element.name == entry.key);
      if (skuCategory == null) {
        //如果该分组不存在，则创建分组信息
        skuCategory = GoodsSkuCategoryEntity();
        skuCategory.name = entry.key;
        skuCategories.add(skuCategory);
      }
      //将sku添加到分组里
      var spec = GoodsSkuSpecEntity()
        ..id = skuId
        ..name = entry.value
        ..coverUrl = coverUrl
        ..price = price;
      skuCategory.skuSpecs.add(spec);

      //添加sku
      var sku = GoodsSkuEntity()
        ..id = skuId
        ..name = skuInfo;
      skus.add(sku);
    }
  }

  Map<String, String>? _parseSku(String skuInfo) {
    if (skuInfo.startsWith('{') && skuInfo.endsWith('}')) {
      Map<String, String> map = {};
      for (var value in skuInfo.substring(1, skuInfo.length -1).split('，')) {
        var strings = value.split(':');
        if (strings.length > 1) {
          map[strings[0]] = strings[1];
        }
      }
      return map;
    }
    return null;
  }
}
