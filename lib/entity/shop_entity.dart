import 'package:storetools/api/api_entity.dart';
import 'package:storetools/const/apis.dart';

///店铺
class ShopEntity implements ApiEntity<ShopEntity> {
  @override String? objectId;
  @override String className = Apis.lcNameShop;
  String name = '';

  @override
  ShopEntity fromJson(Map<String, dynamic> json) {
    var entity = ShopEntity();
    entity.objectId = json['objectId'];
    entity.name = json['name'];
    return entity;
  }

  @override
  Map<String, dynamic> toJson() => {
    'objectId': objectId,
    'name': name
  };
}