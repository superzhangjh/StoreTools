import 'package:storetools/entity/base_entity.dart';

class ProducerSkuEntity implements BaseEntity<ProducerSkuEntity> {
  ///货源价
  double price = 0;
  //分类名
  String categoryName = '';
  ///规格名
  String specName = '';

  @override
  ProducerSkuEntity fromJson(Map<String, dynamic> json) => ProducerSkuEntity()
      ..price = json['price']
      ..categoryName = json['categoryName']
      ..specName = json['specName'];

  @override
  Map<String, dynamic> toJson() => {
    'price': price,
    'categoryName': categoryName,
    'specName': specName
  };
}