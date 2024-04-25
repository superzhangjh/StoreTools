import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///运费价格
class FreightPriceEntity implements BaseEntity<FreightPriceEntity> {
  //运费
  double price = 0;
  //绑定的产品规格
  List<ProducerCategoryEntity>? producerCategories;

  @override
  FreightPriceEntity fromJson(Map<String, dynamic> json) => FreightPriceEntity()
    ..price = json['price']
    ..producerCategories = json.getList('producerCategories', converter: (e) => ProducerCategoryEntity().fromJson(e))?.toList();

  @override
  Map<String, dynamic> toJson() => {
    'price': price,
    'producerCategories': producerCategories?.map((e) => e.toJson()).toList()
  };
}