import 'package:storetools/entity/base_entity.dart';

///sku
class GoodsSkuEntity implements BaseEntity<GoodsSkuEntity> {
  //id
  String id = '';
  //名称
  String name = '';
  //昵称(自定义的名称)
  String? nickName;
  //sku图
  String? coverUrl;
  //价格
  double price = 0;
  //成本价
  double? costPrice;

  @override
  GoodsSkuEntity fromJson(Map<String, dynamic> json) => GoodsSkuEntity()
    ..id = json['id']
    ..name = json['name']
    ..nickName = json['nickName']
    ..coverUrl = json['coverUrl']
    ..price = json['price']
    ..costPrice = json['costPrice'];

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nickName': nickName,
    'coverUrl': coverUrl,
    'price': price,
    'costPrice': costPrice
  };
}