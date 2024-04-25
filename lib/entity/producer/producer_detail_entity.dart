import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/const/apis.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/entity/producer/producer_sku_entity.dart';
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
  ///规格信息
  List<ProducerCategoryEntity> categories = [];
  ///是否使用运费
  bool useFreight = false;
  ///阶梯运费
  List<FreightEntity>? freights;

  @override
  ProducerDetailEntity fromJson(Map<String, dynamic> json) => ProducerDetailEntity()
    ..objectId = json['objectId']
    ..name = json['name']
    ..categories = json.getList('categories', converter: (e) => ProducerCategoryEntity().fromJson(e)) ?? []
    ..useFreight = json['useFreight']
    ..freights = json.getList('freights', converter: (e) => FreightEntity().fromJson(e));

  @override
  Map<String, dynamic> toJson() => {
    'objectId': objectId,
    'name': name,
    'categories': categories.map((e) => e.toJson()).toList(),
    'useFreight': useFreight,
    'freights': freights?.map((e) => e.toJson()).toList()
  };
}