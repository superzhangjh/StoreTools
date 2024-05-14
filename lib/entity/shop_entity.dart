import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/api/apis.dart';

///店铺
class ShopEntity extends ApiEntity<ShopEntity> {
  String name = '';

  ShopEntity() : super(Apis.lcNameShop);

  @override
  Map<String, dynamic> convertToJson() => {
    'name': name
  };

  @override
  ShopEntity createFromJson(Map<String, dynamic> json) => ShopEntity()
    ..name = json['name'];
}