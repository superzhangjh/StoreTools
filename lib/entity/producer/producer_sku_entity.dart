// import 'package:storetools/entity/base_entity.dart';
// import 'package:storetools/entity/goods_sku_entity.dart';
//
// class ProducerSkuEntity implements BaseEntity<ProducerSkuEntity> {
//   ///对应[GoodsSkuEntity]的id
//   String? goodsSkuId;
//   String? name;
//   ///货源价
//   double price = 0;
//
//   @override
//   ProducerSkuEntity fromJson(Map<String, dynamic> json) {
//     final entity = ProducerSkuEntity();
//     entity.goodsSkuId = json['goodsSkuId'];
//     entity.name = json['name'];
//     entity.price = json['price'];
//     return entity;
//   }
//
//   @override
//   Map<String, dynamic> toJson() => {
//     'goodsSkuId': goodsSkuId,
//     'name': name,
//     'price': price
//   };
// }