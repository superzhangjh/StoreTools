import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_controller.dart';
import 'package:storetools/entity/freight/freight_entity.dart';
import 'package:storetools/entity/freight/tag_freight_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/utils/log_utils.dart';
import 'package:storetools/utils/province_utils.dart';

import '../../../const/provinces.dart';
import '../../../entity/producer/producer_detail_entity.dart';
import '../../../utils/dialog_utils.dart';

class ProducerFreightEditorController extends BaseController {
  final ProducerDetailEntity producer;
  final int? selectedIndex;

  late final TextEditingController nameInputController;
  late final TextEditingController priceInputController;

  //省份信息
  final provinceWrappers = <ProvinceWrapper>[].obs;
  //标签运费
  final tagFreightWrappers = <TagFreightWrapper>[].obs;
  //标签运费输入框集合
  final tagFreightControllerMap = <String, TextEditingController>{};

  ProducerFreightEditorController({ required this.producer, required this.selectedIndex });

  @override
  void onInit() {
    super.onInit();
    logDebug("selectedIndex:$selectedIndex");
    _initEditingController();
    _initProvinceWrappers();
    _initTagFreight();
  }

  FreightEntity? getSelectedFreight() {
    return producer.freights?.getSafeOfNull(selectedIndex);
  }

  _initEditingController() {
    final selectedFreight = getSelectedFreight();
    nameInputController = TextEditingController(text: selectedFreight?.name ?? "");
    priceInputController = TextEditingController(text: selectedFreight?.price.toString() ?? "0");
  }

  _initProvinceWrappers() {
    final selectedFreight = getSelectedFreight();
    provinceWrappers.value = Province.values.mapIndex((index, value) {
      final code = value.name;
      bool selected = selectedFreight?.provinceCodes.contains(code) ?? false;
      bool enable = selected || producer.freights?.findWithIndex((element, i) => i != selectedIndex && element.provinceCodes.contains(code) == true) == null;
      return ProvinceWrapper(provinceCode: code, selected: selected, enable: enable);
    }) ?? [];
  }

  _initTagFreight() {
    tagFreightControllerMap.clear();
    final selectedFreight = getSelectedFreight();
    tagFreightWrappers.addAll(producer.tags?.map((e) {
      final found = selectedFreight?.tagFreights?.find((element) => element.tag?.id == e.id);
      final price = found?.price ?? 0;
      final tagFreight = TagFreightEntity()
        ..price = price
        ..tag = e;
      tagFreightControllerMap[tagFreight.tag!.id] = TextEditingController(text: price.toString());
      return TagFreightWrapper(
          tagFreight: tagFreight,
          isChecked: found != null
      );
    }) ?? []);
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
    var useFreight = producer.freights.findWithIndex((element, index) =>
      index != selectedIndex && element.provinceCodes.contains(wrapper.provinceCode) == true);
    if (useFreight != null) {
      showConfirmDialog(
          '“${ProvinceUtils.getInstance().getNameByCode(wrapper.provinceCode)}”'
              '已被“${useFreight.name}”使用了，是否移动到当前阶梯运费”?',
          onPositiveClick: () {
            wrapper.enable = true;
            _toggleProvinceSelect(wrapper);
            return true;
          });
    }
  }

  ///切换选中状态
  toggleTagFreightCheck(int index, bool? isChecked) {
    final wrapper = tagFreightWrappers[index];
    wrapper.isChecked = isChecked ?? false;
    tagFreightWrappers.setSafe(index, wrapper);
  }

  ///保存改动的运费
  save() {
    var name = nameInputController.text.trim();
    if (name.isEmpty) name = '默认运费${DateTime.now().millisecondsSinceEpoch}';

    //标签运费信息
    final tagFreights = tagFreightWrappers.filter((e) => e.isChecked)?.map((e) {
      final tagFreight = e.tagFreight;
      tagFreight.price = double.parse(tagFreightControllerMap[tagFreight.tag?.id ?? '']?.text ?? "0");
      return tagFreight;
    }).toList();

    //赋值当前的阶梯运费
    final selectedFreight = getSelectedFreight() ?? FreightEntity()
      ..name = name
      ..price = double.parse(priceInputController.text.trim())
      ..provinceCodes = provinceWrappers.filter((e) => e.selected)?.map((e) => e.provinceCode).toList() ?? []
      ..tagFreights = tagFreights;

    //更新货源的所有阶梯运费
    producer.freights = producer.freights?.mapIndex((index, e) {
      if (index == selectedIndex) {
        return selectedFreight;
      } else {
        //移除当前阶梯运费选中的省份
        for (var value in selectedFreight.provinceCodes) {
          e.provinceCodes.remove(value);
        }
        return e;
      }
    }) ?? [];

    //如果是新建的，则添加到数组
    if (selectedIndex == null) {
      producer.freights?.add(selectedFreight);
    }

    Get.back();
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
  // TextEditingController controller;
  bool isChecked;

  TagFreightWrapper({ required this.tagFreight, required this.isChecked });
}