import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_controller.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/entity/producer/producer_tag_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/route/route_result.dart';
import 'package:storetools/utils/dialog_utils.dart';
import 'package:storetools/utils/log_utils.dart';
import 'package:storetools/utils/short_uuid_utils.dart';

import '../../api/api.dart';
import '../../base/bottom_sheet_page.dart';
import '../../const/arguments.dart';
import '../../entity/producer/producer_detail_entity.dart';
import '../../entity/producer/producer_spec_entity.dart';
import '../../utils/route_arguments_utils.dart';
import '../../utils/toast_utils.dart';
import 'freight_editor/producer_freight_editor_page.dart';

class ProducerEditorController extends BaseController {
  late Rx<ProducerDetailEntity> producer = Rx(getArgument<ProducerDetailEntity>(Arguments.producer)?.copy() ?? ProducerDetailEntity());
  late final TextEditingController nameController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: producer.value.name);
  }

  ///新建分类
  FutureOr<bool> createOrUpdateCategory(bool create, String name, List<ProducerTagEntity> tags) {
    if (name.isEmpty) {
      showToast('名称未填写');
      return false;
    }

    var category = producer.value.categories.find((e) => e.name == name);
    if (create && category != null) {
      showToast('该分类已存在');
      return false;
    }

    category ??= ProducerCategoryEntity();
    category.name = name;
    category.tags = tags;
    producer.update((val) {
      if (create) {
        val?.categories.add(category!);
      } else {
        val?.categories.replaceWhen(category!, (element) => element.name == category!.name);
      }
    });
    return true;
  }

  ///新建规格
  FutureOr<bool> createOrUpdateSpec(ProducerCategoryEntity category, int? specIndex, String name, double cost, String? tagId) {
    if (name.isEmpty) {
      showToast('名称未填写');
      return false;
    }
    var found = category.specs.findWithIndex((e, index) => index != specIndex && e.name == name);
    if (found != null) {
      showToast('该规格已存在');
      return false;
    }
    final spec = category.specs.getSafeOfNull(specIndex) ?? ProducerSpecEntity();
    spec.name = name;
    spec.cost = cost;
    spec.tagId = tagId;
    if (specIndex == null) {
      category.specs.add(spec);
    } else {
      category.specs.setSafe(specIndex, spec);
    }
    var categoryIndex = producer.value.categories.findIndex((element) => element.name == category.name);
    producer.update((val) {
      val?.categories.setSafe(categoryIndex, category);
    });
    return true;
  }

  ///切换使用运费
  toggleUseStepFreight(bool useStepFreight) {
    logDebug("切换使用运费:$useStepFreight");
    producer.update((val) {
      val?.useStepFreight = useStepFreight;
    });
  }

  ///运费编辑
  ///[useStepFreight]使用运费模板
  showFreightEditor(bool useStepFreight, {int? index}) async {
    final result = await bottomSheetPage<RouteResult>(ProducerFreightEditorPage(
        producer: producer.value,
        useStepFreight: useStepFreight,
        selectedStepIndex: index
    ));
    logDebug("请求结果:${jsonEncode(result)}");
    switch (result?.code) {
      case RouteResult.resultOk:
      case RouteResult.resultDelete:
        producer.refresh();
        break;
    }
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

    final result = await Api.createOrUpdate(producer.value);
    if (result.isSuccess()) {
      showToast('保存成功');
      Get.back(result: RouteResult(code: RouteResult.resultOk, data: result.data));
    } else {
      showToast(result.msg);
    }
  }

  delete() {
    showConfirmDialog('删除后无法恢复数据，确认删除？', positiveText: '删除', onPositiveClick: () {
      _doDelete();
    });
  }

  _doDelete() async {
    final result = await Api.createOrUpdate(producer.value);
    if (result.isSuccess()) {
      showToast('删除成功');
      Get.back(result: RouteResult(code: RouteResult.resultDelete, data: result.data));
    } else {
      showToast(result.msg);
    }
  }
}