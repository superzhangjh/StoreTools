import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_controller.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/entity/producer/producer_sku_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/utils/log_utils.dart';

import '../../api/api.dart';
import '../../const/arguments.dart';
import '../../entity/producer/producer_detail_entity.dart';
import '../../entity/producer/producer_spec_entity.dart';
import '../../utils/route_arguments_utils.dart';
import '../../utils/toast_utils.dart';

class ProducerEditorController extends BaseController {
  late Rx<ProducerDetailEntity> producer = Rx(getArgument(Arguments.producer) ?? ProducerDetailEntity());
  late final TextEditingController nameController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: producer.value.name);
  }

  ///新建分类
  FutureOr<bool> createCategory(String name) {
    var found = producer.value.categories.find((e) => e.name == name);
    if (found != null) {
      showToast('该分类已存在');
      return false;
    }
    var category = ProducerCategoryEntity();
    category.name = name;
    producer.update((val) {
      val?.categories.add(category);
    });
    return true;
  }

  ///新建规格
  FutureOr<bool> createSpec(ProducerCategoryEntity category, String name) {
    var found = category.specs.find((e) => e.name == name);
    if (found != null) {
      showToast('该规格已存在');
      return false;
    }
    var spec = ProducerSpecEntity();
    spec.name = name;
    category.specs.add(spec);
    var categoryIndex = producer.value.categories.findIndex((element) => element.name == category.name);
    producer.update((val) {
      val?.categories?.setSafe(categoryIndex, category);
    });
    return true;
  }

  ///切换使用运费
  toggleUseFreight(bool useFreight) {
    logDebug("切换使用运费:$useFreight");
    producer.update((val) {
      val?.useFreight = useFreight;
    });
  }

  ///保存数据到服务器
  save() async {
    var name = nameController.text.trim();
    if (name.isEmpty) name = '货源${DateTime.now().millisecondsSinceEpoch}';
    producer.value.name = name;

    final categories = producer.value.categories;
    if (categories.isEmpty || categories.find((e) => e.specs.isNullOrEmpty()) != null) {
      showToast('分类数据或者分类规格未填写，请检查后重试');
      return;
    }

    var result = await Api.createOrUpdate(producer.value);
    if (result.isSuccess()) {
      showToast('保存成功');
      Get.back(result: result.data);
    } else {
      showToast(result.msg);
    }
  }
}