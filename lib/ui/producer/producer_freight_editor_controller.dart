import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:storetools/entity/freight/freight_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/utils/log_utils.dart';

import '../../const/provinces.dart';
import '../../entity/producer/producer_detail_entity.dart';

class ProducerFreightEditorController extends GetxController {
  final ProducerDetailEntity producer;
  final int? selectedIndex;

  final provinceWrappers = <ProvinceWrapper>[].obs;
  final currentFreight = Rx<FreightEntity?>(null);

  late final TextEditingController nameInputController;
  late final TextEditingController priceInputController;

  ProducerFreightEditorController({ required this.producer, required this.selectedIndex });

  @override
  void onInit() {
    super.onInit();
    logDebug("selectedIndex:$selectedIndex");

    final selectedFreight = getSelectedFreight();
    nameInputController = TextEditingController(text: selectedFreight?.name ?? "");
    priceInputController = TextEditingController(text: selectedFreight?.price.toString() ?? "");
    _initProvinceWrappers();
  }

  FreightEntity? getSelectedFreight() {
    return producer.freights?.getSafeOfNull(selectedIndex);
  }

  _initProvinceWrappers() {
    final selectedFreight = getSelectedFreight();
    provinceWrappers.value = Province.values.mapIndex((index, value) {
      final code = value.name;
      bool selected = selectedFreight?.provinceCodes?.contains(code) ?? false;
      bool enable = selected || producer.freights?.findWithIndex((element, i) => i != selectedIndex && element.provinceCodes?.contains(code) == true) == null;
      return ProvinceWrapper(provinceCode: code, selected: selected, enable: enable);
    }) ?? [];
  }
}

class ProvinceWrapper {
  String provinceCode;
  bool selected;
  bool enable;

  ProvinceWrapper({ required this.provinceCode, required this.selected, required this.enable });
}