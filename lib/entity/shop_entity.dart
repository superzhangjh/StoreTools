import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/api/apis.dart';

///店铺
class ShopEntity extends ApiEntity<ShopEntity> {
  @override String? objectId;
  @override String className = Apis.lcNameShop;
  String name = '';

  @override
  ShopEntity fromJson(Map<String, dynamic> json) => ShopEntity()
    ..objectId = json['objectId']
    ..name = json['name'];

  @override
  Map<String, dynamic> toJson() => {
    'objectId': objectId,
    'name': name
  };
}