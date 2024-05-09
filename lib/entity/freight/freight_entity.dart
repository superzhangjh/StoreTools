import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/entity/freight/tag_freight_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///运费
class FreightEntity implements BaseEntity<FreightEntity> {
  String name = '';
  //通用价格
  double price = 0;
  //指定的省份编码
  List<String>? provinceCodes;
  //指定标签的运费
  List<TagFreightEntity>? tagFreights;

  @override
  FreightEntity fromJson(Map<String, dynamic> json) => FreightEntity()
    ..name = json['name']
    ..price = json['price']
    ..provinceCodes = json.getList('provinceCodes')
    ..tagFreights = json.getList('tagFreights', converter: (e) => TagFreightEntity().fromJson(e))?.toList();

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'provinceCodes': provinceCodes,
    'tagFreights': tagFreights?.map((e) => e.toJson()).toList()
  };
}