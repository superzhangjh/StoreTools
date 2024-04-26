import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/ext/map_ext.dart';

import 'freight_price_entity.dart';

///运费
class FreightEntity implements BaseEntity<FreightEntity> {
  String name = '';
  //通用价格
  double price = 0;
  //特定规格的价格
  List<FreightPriceEntity>? categoryPrices;
  //指定的省份编码
  List<String> provinceCodes = [];

  @override
  FreightEntity fromJson(Map<String, dynamic> json) => FreightEntity()
    ..name = json['name']
    ..price = json['price']
    ..categoryPrices = json.getList('categoryPrices', converter: (e) => FreightPriceEntity().fromJson(e))?.toList()
    ..provinceCodes = json.getList('provinceCodes') ?? [];

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'categoryPrices': categoryPrices?.map((e) => e.toJson()).toList(),
    'provinceCodes': provinceCodes
  };
}