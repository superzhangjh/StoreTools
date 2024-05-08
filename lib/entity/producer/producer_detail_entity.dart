import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/const/apis.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/entity/producer/producer_tag_entity.dart';
import 'package:storetools/ext/map_ext.dart';

import '../freight/freight_entity.dart';

///货源详情
class ProducerDetailEntity implements ApiEntity<ProducerDetailEntity> {
  @override
  String className = Apis.lcNameProducer;
  @override
  String? objectId;
  ///货源名称
  String name = '';
  //分类规格
  List<ProducerCategoryEntity> categories = [];
  ///是否使用运费模板
  bool useFreight = false;
  ///阶梯运费
  List<FreightEntity>? freights;
  ///统一的运费
  double unifiedPrice = 0;
  ///标签
  List<ProducerTagEntity>? tags;

  @override
  ProducerDetailEntity fromJson(Map<String, dynamic> json) => ProducerDetailEntity()
    ..objectId = json['objectId']
    ..name = json['name']
    ..categories = json.getList("categories", converter: (e) => ProducerCategoryEntity().fromJson(e)) ?? []
    ..useFreight = json['useFreight']
    ..freights = json.getList('freights', converter: (e) => FreightEntity().fromJson(e))
    ..unifiedPrice = json.getDouble('unifiedPrice') ?? 0
    ..tags = json.getList('tags', converter: (e) => ProducerTagEntity().fromJson(e));

  @override
  Map<String, dynamic> toJson() => {
    'objectId': objectId,
    'name': name,
    'categories': categories.map((e) => e.toJson()).toList(),
    'useFreight': useFreight,
    'freights': freights?.map((e) => e.toJson()).toList(),
    'unifiedPrice': unifiedPrice,
    'tags': tags?.map((e) => e.toJson()).toList()
  };
}