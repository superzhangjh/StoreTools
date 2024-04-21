import 'package:storetools/entity/base_entity.dart';

class ProvinceEntity implements BaseEntity<ProvinceEntity> {
  String name = '';
  String code = '';

  @override
  ProvinceEntity fromJson(Map<String, dynamic> json) {
    final entity = ProvinceEntity();
    entity.name = json['name'];
    entity.code = json['code'];
    return entity;
  }

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code
  };
}