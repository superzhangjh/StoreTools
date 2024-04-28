import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/base/bottom_sheet_page.dart';
import 'package:storetools/entity/freight/sku_freight_entity.dart';
import 'package:storetools/entity/producer/producer_sku_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ui/producer/freight_editor/producer_freight_editor_controller.dart';
import 'package:storetools/utils/toast_utils.dart';

import '../../../widget/text_input_widget.dart';

class ProducerFreightSpecPage extends BottomSheetPage {
  const ProducerFreightSpecPage({super.key});

  @override
  BottomSheetState<BasePage> createBottomSheetState() => ProducerFreightSpecState();
}

class ProducerFreightSpecState extends BottomSheetState<ProducerFreightSpecPage> {
  final _controller = Get.find<ProducerFreightEditorController>();
  final _inputController = TextEditingController(text: "0");
  late List<ProductSkuWrapper> _skuWrappers;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    //todo:这里应该用所有spec互相组合成为新的sku
    _skuWrappers = _controller.producer.skus.map((e) => ProductSkuWrapper(isSelect: false, sku: e)).toList();
  }

  @override
  CustomScrollView buildScroll(BuildContext context, ScrollController controller) {
    return CustomScrollView(
      controller:  controller,
      slivers: [
        SliverAppBar(
          title: const Text('指定规格运费'),
          floating: true,
          pinned: true,
          actions: [
            TextButton(
                onPressed: () => _save(),
                child: const Text('保存')
            )
          ],
        ),
        SliverToBoxAdapter(
          child: TextInputWidget.number(controller: _inputController, label: '价格'),
        ),
        SliverList(
            delegate: SliverChildListDelegate(_skuWrappers.mapIndex((index, e) => _buildSpecWrapper(index, e)) ?? [])
        )
      ],
    );
  }

  Widget _buildSpecWrapper(int index, ProductSkuWrapper wrapper) => GestureDetector(
    onTap: () {
      setState(() {
        wrapper.isSelect = !wrapper.isSelect;
        _skuWrappers.setSafe(index, wrapper);
      });
    },
    child: Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 40,
      child: Row(
        children: [
          Icon(wrapper.isSelect? Icons.check_box: Icons.check_box_outline_blank, size: 20),
          Text(wrapper.sku.categoryName + wrapper.sku.specName)
        ],
      ),
    ),
  );

  _save() {
    final selectedSpecWrappers = _skuWrappers.filter((element) => element.isSelect);
    if (selectedSpecWrappers.isNullOrEmpty()) {
      showToast('未选择任何规格');
      return;
    }
    final skuFreight = SkuFreightEntity()
      ..price = double.parse(_inputController.text.trim())
      ..skus = selectedSpecWrappers?.map((e) => e.sku).toList() ?? [];
    _controller.addSkuFreight(skuFreight);
    Get.back();
  }
}

class ProductSkuWrapper {
  bool isSelect;
  ProducerSkuEntity sku;

  ProductSkuWrapper({ required this.isSelect, required this.sku });
}