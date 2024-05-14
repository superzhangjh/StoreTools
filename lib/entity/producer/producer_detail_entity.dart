import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/api/apis.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/ext/map_ext.dart';

import '../freight/freight_entity.dart';

///货源详情
class ProducerDetailEntity extends ApiEntity<ProducerDetailEntity> {
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
  ///绑定的商品id列表
  List<String> goodsIds = [];

  ProducerDetailEntity({ bool onlyQueryKeys = false }) : super(Apis.lcNameProducer, onlyQueryKeys);

  @override
  Map<String, dynamic> convertToJson() => {
    'name': name,
    'categories': categories.map((e) => e.toJson()).toList(),
    'useStepFreight': useStepFreight,
    'freight': freight?.toJson(),
    'stepFreights': stepFreights?.map((e) => e.toJson()).toList() ?? [],
    'goodsIds': goodsIds
  };

  @override
  ProducerDetailEntity createFromJson(Map<String, dynamic> json) => ProducerDetailEntity()
    ..name = json.getString('name') ?? ''
    ..categories = json.getList("categories", converter: (e) => ProducerCategoryEntity().fromJson(e)) ?? []
    ..useStepFreight = json.getBool('useStepFreight') ?? false
    ..freight = json.getObject("freight", converter: (e) => FreightEntity().fromJson(e))
    ..stepFreights = json.getList('stepFreights', converter: (e) => FreightEntity().fromJson(e))
    ..goodsIds = json.getList('goodsIds') ?? [];

  ///是否已绑定商品
  bool isBoundGoods() => goodsIds.isNotEmpty == true;

  @override
  List<String>? getQueryPartKeys() => ['name', 'goodsIds'];
}