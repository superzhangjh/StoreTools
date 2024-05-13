import 'dart:convert';

import 'package:storetools/entity/base/base_entity.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/ext/list_ext.dart';

import '../../utils/log_utils.dart';

class ProducerSkuEntity extends BaseEntity<ProducerSkuEntity> {
  ///货源价
  double price = 0;
  ///名称
  String name = '';

  static List<ProducerSkuEntity> fromCategories(List<ProducerCategoryEntity> categories) => _generateSkus(categories);

  static List<ProducerSkuEntity> _generateSkus(List<ProducerCategoryEntity> categories, { List<ProducerSkuEntity>? skus }) {
    logDebug("开始匹配 skus:${jsonEncode(skus)} categories:${jsonEncode(categories)}");
    if (categories.isEmpty) return [];
    List<ProducerSkuEntity> newSkus = [];
    final category = categories.first;
    if (skus.isNullOrEmpty()) {
      newSkus.addAll(category.specs.map((e) => ProducerSkuEntity()
        ..name = e.name
      ));
    } else {
      logDebug("调试 skus:${jsonEncode(skus)} specs:${jsonEncode(category.specs)}");
      for (var sku in skus!) {
        for (var spec in category.specs) {
          newSkus.add(ProducerSkuEntity()..name = "${sku.name} ${spec.name}");
        }
      }
    }
    if (categories.length > 1) {
      return _generateSkus(categories.sublist(1), skus: newSkus);
    }
    return newSkus;
  }

  @override
  ProducerSkuEntity fromJson(Map<String, dynamic> json) => ProducerSkuEntity()
      ..price = json['price']
      ..name = json['name'];

  @override
  Map<String, dynamic> toJson() => {
    'price': price,
    'name': name
  };
}