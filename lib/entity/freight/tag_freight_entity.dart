import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/entity/producer/producer_tag_entity.dart';
import 'package:storetools/ext/map_ext.dart';

///指定标签的运费
class TagFreightEntity extends BaseEntity<TagFreightEntity> {
  double price = 0;
  ProducerTagEntity? tag;

  @override
  TagFreightEntity fromJson(Map<String, dynamic> json) => TagFreightEntity()
    ..price = json.getDouble("price") ?? 0
      ..tag = json.getObject('tag', converter: (e) => ProducerTagEntity().fromJson(e));

  @override
  Map<String, dynamic> toJson() => {
    'price': price,
    'tag': tag?.toJson()
  };
}