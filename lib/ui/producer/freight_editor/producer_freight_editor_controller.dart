import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_controller.dart';
import 'package:storetools/entity/freight/freight_entity.dart';
import 'package:storetools/entity/freight/tag_freight_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ext/text_editing_controller_ext.dart';
import 'package:storetools/route/route_result.dart';
import 'package:storetools/utils/province_utils.dart';

import '../../../const/provinces.dart';
import '../../../entity/producer/producer_detail_entity.dart';
import '../../../utils/dialog_utils.dart';

class ProducerFreightEditorController extends BaseController {
  final ProducerDetailEntity producer;
  final bool useStepFreight;
  final int? selectedStepIndex;

  late final TextEditingController nameInputController;
  late final TextEditingController priceInputController;

  //省份信息
  final provinceWrappers = <ProvinceWrapper>[].obs;
  //标签运费
  final tagFreights = <TagFreightEntity>[].obs;
  //标签运费输入框集合
  final tagFreightControllerMap = <String, TextEditingController>{};

  ProducerFreightEditorController({ required this.producer, required this.useStepFreight, required this.selectedStepIndex });

  @override
  void onInit() {
    super.onInit();
    _initEditingController();
    _initProvinceWrappers();
    _initTagFreight();
  }

  FreightEntity? getSelectedFreight() {
    return useStepFreight? producer.stepFreights?.getSafeOfNull(selectedStepIndex): producer.freight;
  }

  _initEditingController() {
    final selectedFreight = getSelectedFreight();
    nameInputController = TextEditingController(text: selectedFreight?.name);
    priceInputController = TextEditingController(text: selectedFreight?.price.toString());
  }

  _initProvinceWrappers() {
    if (useStepFreight) {
      final selectedFreight = getSelectedFreight();
      provinceWrappers.value = Province.values.mapIndex((index, value) {
        final code = value.name;
        bool selected = selectedFreight?.provinceCodes?.contains(code) ?? false;
        bool enable = selected || producer.stepFreights?.findWithIndex((element, i) => i != selectedStepIndex && element.provinceCodes?.contains(code) == true) == null;
        return ProvinceWrapper(provinceCode: code, selected: selected, enable: enable);
      }) ?? [];
    }
  }

  _initTagFreight() {
    tagFreightControllerMap.clear();
    final selectedFreight = getSelectedFreight();
    List<TagFreightEntity>? data;
    for (var category in producer.categories) {
      category.tags?.forEach((tag) {
        final found = selectedFreight?.tagFreights?.find((element) => element.tag?.id == tag.id);
        final price = found?.price;
        final tagFreight = TagFreightEntity()
          ..price = price ?? 0
          ..tag = tag;
        tagFreightControllerMap[tagFreight.tag!.id] = TextEditingController(text: price?.toString());
        data ??= [];
        data?.add(tagFreight);
      });
    }
    if (data != null) {
      tagFreights.addAll(data!);
    }
  }

  ///省份点击事件
  void triggerProvinceClick(ProvinceWrapper wrapper) {
    if (wrapper.enable) {
      _toggleProvinceSelect(wrapper);
    } else {
      _showMoveProvinceDialog(wrapper);
    }
  }

  ///切换选中
  void _toggleProvinceSelect(ProvinceWrapper wrapper) {
    wrapper.selected = !wrapper.selected;
    final index = provinceWrappers.findIndex((element) => element.provinceCode == wrapper.provinceCode);
    if (index >= 0) {
      provinceWrappers.setSafe(index, wrapper);
    }
  }

  ///将其他阶梯运费选中的省份移动到当前
  _showMoveProvinceDialog(ProvinceWrapper wrapper) {
    var useFreight = producer.stepFreights.findWithIndex((element, index) =>
      index != selectedStepIndex && element.provinceCodes?.contains(wrapper.provinceCode) == true);
    if (useFreight != null) {
      showConfirmDialog(
          '“${ProvinceUtils.getInstance().getNameByCode(wrapper.provinceCode)}”'
              '已被“${useFreight.name}”使用了，是否移动到当前阶梯运费”?',
          onPositiveClick: () {
            wrapper.enable = true;
            _toggleProvinceSelect(wrapper);
          });
    }
  }

  ///保存改动的运费
  save() {
    var name = nameInputController.text.trim();
    if (name.isEmpty) name = '默认运费${DateTime.now().millisecondsSinceEpoch}';

    //标签运费信息
    List<TagFreightEntity>? activeTagFreights;
    for (var element in tagFreights) {
      final price = tagFreightControllerMap[element.tag?.id ?? '']?.doubleValue();
      if (price != null) {
        element.price = price;
        activeTagFreights ??= [];
        activeTagFreights.add(element);
      }
    }

    //赋值当前的阶梯运费
    final selectedFreight = getSelectedFreight() ?? FreightEntity()
      ..name = name
      ..price = priceInputController.doubleValue() ?? 0
      ..provinceCodes = provinceWrappers.filter((e) => e.selected)?.map((e) => e.provinceCode).toList() ?? []
      ..tagFreights = activeTagFreights;

    if (useStepFreight) {
      //更新货源的所有阶梯运费
      producer.stepFreights = producer.stepFreights?.mapIndex((index, e) {
        if (index == selectedStepIndex) {
          return selectedFreight;
        } else {
          //移除当前阶梯运费选中的省份
          selectedFreight.provinceCodes?.forEach((element) {
            e.provinceCodes?.remove(element);
          });
          return e;
        }
      }) ?? [];

      //如果是新建的，则添加到数组
      if (selectedStepIndex == null) {
        producer.stepFreights?.add(selectedFreight);
      }
    } else {
      producer.freight = selectedFreight;
    }
    Get.back(result: RouteResult(code: RouteResult.resultOk));
  }

  delete() {
    showConfirmDialog('确认删除？', positiveText: '删除', onPositiveClick: () {
      if (useStepFreight) {
        producer.stepFreights?.removeAtSafe(selectedStepIndex);
      } else {
        producer.freight = null;
      }
      Get.back(result: RouteResult(code: RouteResult.resultDelete));
    });
  }
}

class ProvinceWrapper {
  String provinceCode;
  bool selected;
  bool enable;

  ProvinceWrapper({ required this.provinceCode, required this.selected, required this.enable });
}

class TagFreightWrapper {
  TagFreightEntity tagFreight;
  bool isChecked;

  TagFreightWrapper({ required this.tagFreight, required this.isChecked });
}