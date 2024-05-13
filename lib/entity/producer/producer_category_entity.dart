import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/entity/base/base_with_id_entity.dart';
import 'package:storetools/entity/producer/producer_spec_entity.dart';
import 'package:storetools/entity/producer/producer_tag_entity.dart';
import 'package:storetools/ext/map_ext.dart';
import 'package:storetools/utils/log_utils.dart';

class ProducerCategoryEntity extends BaseWithIdEntity<ProducerCategoryEntity> {
  ///名称
  String name = '';
  ///规格
  List<ProducerSpecEntity> specs = [];
  ///标签
  List<ProducerTagEntity>? tags;

  @override
  ProducerCategoryEntity createFromJson(Map<String, dynamic> json) => ProducerCategoryEntity()
    ..name = json['name']
    ..specs = json.getList('specs', converter: (e) => ProducerSpecEntity().fromJson(e))?.toList() ?? []
    ..tags = json.getList('tags', converter: (e) => ProducerTagEntity().fromJson(e))?.toList();

  @override
  void fillToJson(Map<String, dynamic> json) {
    json['name'] = name;
    try {
      json['specs'] = specs.map((e) => e.toJson()).toList();
      // json['tags'] = tags?.map((e) => e.toJson()).toList();
    } catch (e) {
      logDebug("producer_category_entity 错误：$e");
    }
  }
}