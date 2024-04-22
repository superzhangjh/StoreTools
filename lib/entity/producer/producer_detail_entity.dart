import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/const/apis.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/entity/producer/producer_sku_entity.dart';
import 'package:storetools/ext/map_ext.dart';

import '../freight_entity.dart';

///货源详情
class ProducerDetailEntity implements ApiEntity<ProducerDetailEntity> {
  @override
  String className = Apis.lcNameProducer;
  @override
  String? objectId;
  ///货源名称
  String name = '';
  ///规格信息
  List<ProducerCategoryEntity> categories = [];
  ///sku：把每个分类里的单个规格组合起来后成为sku
  List<ProducerSkuEntity> skus = [];
  ///是否使用运费
  bool useFreight = false;
  ///阶梯运费
  List<FreightEntity>? freights;

  @override
  ProducerDetailEntity fromJson(Map<String, dynamic> json) {
    final entity = ProducerDetailEntity();
    entity.objectId = json['objectId'];
    entity.name = json['name'];
    entity.categories = json.getList('categories', converter: (e) => ProducerCategoryEntity().fromJson(e)) ?? [];
    entity.skus = json.getList('skus', converter: (e) => ProducerSkuEntity().fromJson(e)) ?? [];
    entity.useFreight = json['useFreight'];
    entity.freights = json.getList('freights', converter: (e) => FreightEntity().fromJson(e));
    return entity;
  }

  @override
  Map<String, dynamic> toJson() => {
    'objectId': objectId,
    'name': name,
    'categories': categories.map((e) => e.toJson()).toList(),
    'skus': skus,
    'useFreight': useFreight,
    'freights': freights
  };
}