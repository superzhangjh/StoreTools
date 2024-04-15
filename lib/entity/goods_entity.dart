import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:storetools/entity/goods_sku_entity.dart';
import 'package:storetools/ext/list_ext.dart';

import 'goods_row_entity.dart';
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
  List<GoodsSkuGroupEntity> skuGroups = [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thirdPartyId': thirdPartyId,
      'name': name,
      'coverUrl': coverUrl,
      'skuGroups': skuGroups
    };
  }

  ///将行数据转为商品数据，合并多个sku为一个商品
  static List<GoodsEntity>? fromRows(List<GoodsRowEntity>? rowEntities) {
    if (rowEntities == null || rowEntities.isEmpty) return null;
    List<GoodsEntity> goodsList = [];
    Map<String, GoodsEntity?> goodsMap = {};
    for (var element in rowEntities) {
      var id = element.thirdPartyId;
      var goodsEntity = goodsMap[id];
      if (goodsEntity == null) {
        //创建商品
        goodsEntity = GoodsEntity();
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
      var skuGroup = skuGroups.find((element) => element.name == entry.key);
      if (skuGroup == null) {
        //如果该分组不存在，则创建分组信息
        skuGroup = GoodsSkuGroupEntity();
        skuGroup.name = entry.key;
        skuGroups.add(skuGroup);
      }
      //将sku添加到分组里
      var sku = GoodsSkuEntity();
      sku.id = skuId;
      sku.name = entry.value;
      sku.coverUrl = coverUrl;
      sku.price = price;
      skuGroup.skus.add(sku);
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
