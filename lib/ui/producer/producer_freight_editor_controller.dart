import 'package:get/get.dart';
import 'package:storetools/entity/freight/freight_entity.dart';
import 'package:storetools/ext/list_ext.dart';

import '../../const/provinces.dart';
import '../../entity/producer/producer_detail_entity.dart';

class ProducerFreightEditorController extends GetxController {
  final ProducerDetailEntity producer;
  final int? selectedIndex;
  final provinceWrappers = <ProvinceWrapper>[].obs;

  ProducerFreightEditorController({ required this.producer, required this.selectedIndex });

  @override
  void onInit() {
    super.onInit();
    _initProvinceWrappers();
  }

  FreightEntity? _getSelectedFreight() {
    return null;
  }

  _initProvinceWrappers() {
    provinceWrappers.value = Province.values.mapIndex((index, value) {
      final code = value.name;
      bool selected;
      bool enable;
      if (index == selectedIndex) {
        selected = producer.freights?.getSafeOfNull(selectedIndex)?.provinceCodes?.contains(code) ?? false;
        enable = true;
      } else {
        selected = false;
        enable = producer.freights?.findWithIndex((element, i) => i != index && element.provinceCodes?.contains(code) == true) == null;
      }
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