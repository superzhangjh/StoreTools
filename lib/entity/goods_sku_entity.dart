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
  GoodsSkuEntity fromJson(Map<String, dynamic> json) {
    final entity = GoodsSkuEntity();
    entity.id = json['id'];
    entity.name = json['name'];
    entity.nickName = json['nickName'];
    entity.coverUrl = json['coverUrl'];
    entity.price = json['price'];
    entity.costPrice = json['costPrice'];
    return entity;
  }

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