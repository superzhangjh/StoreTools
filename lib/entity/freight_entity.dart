import 'package:storetools/entity/base_entity.dart';
import 'package:storetools/entity/province_entity.dart';
import 'package:storetools/ext/map_ext.dart';


///运费
class FreightEntity implements BaseEntity<FreightEntity> {
  String name = '';
  double price = 0;
  List<ProvinceEntity>? provinces;

  @override
  FreightEntity fromJson(Map<String, dynamic> json) {
    final entity = FreightEntity();
    entity.name = json['name'];
    entity.price = json['price'];
    entity.provinces = json.getList('provinces', converter: (e) => ProvinceEntity().fromJson(e));
    return entity;
  }

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'provinces': provinces
  };
}