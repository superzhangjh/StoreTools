import 'package:storetools/entity/base_entity.dart';

class ProvinceEntity extends BaseEntity<ProvinceEntity> {
  String name = '';
  String code = '';

  @override
  ProvinceEntity fromJson(Map<String, dynamic> json) => ProvinceEntity()
    ..name = json['name']
    ..code = json['code'];

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code
  };
}