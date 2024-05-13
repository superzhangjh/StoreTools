import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/api/apis.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/entity/producer/producer_tag_entity.dart';
import 'package:storetools/ext/map_ext.dart';

import '../freight/freight_entity.dart';

///货源详情
class ProducerDetailEntity extends ApiEntity<ProducerDetailEntity> {
  @override
  String className = Apis.lcNameProducer;
  @override
  String? objectId;
  ///货源名称
  String name = '';
  //分类规格
  List<ProducerCategoryEntity> categories = [];
  ///使用阶梯运费
  bool useStepFreight = false;
  ///统一运费（与阶梯运费互斥）
  FreightEntity? freight;
  ///阶梯运费
  List<FreightEntity>? stepFreights;

  @override
  ProducerDetailEntity fromJson(Map<String, dynamic> json) => ProducerDetailEntity()
    ..objectId = json['objectId']
    ..name = json['name']
    ..categories = json.getList("categories", converter: (e) => ProducerCategoryEntity().fromJson(e)) ?? []
    ..useStepFreight = json.getBool('useStepFreight') ?? false
    ..freight = json.getObject("freight", converter: (e) => FreightEntity().fromJson(e))
    ..stepFreights = json.getList('stepFreights', converter: (e) => FreightEntity().fromJson(e));

  @override
  Map<String, dynamic> toJson() => {
    'objectId': objectId,
    'name': name,
    'categories': categories.map((e) => e.toJson()).toList(),
    'useStepFreight': useStepFreight,
    'freight': freight?.toJson(),
    'stepFreights': stepFreights?.map((e) => e.toJson()).toList() ?? []
  };
}