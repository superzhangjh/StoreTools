// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:storetools/base/base_page.dart';
// import 'package:storetools/base/bottom_sheet_page.dart';
// import 'package:storetools/entity/freight/sku_freight_entity.dart';
// import 'package:storetools/entity/producer/producer_sku_entity.dart';
// import 'package:storetools/ext/list_ext.dart';
// import 'package:storetools/ui/producer/freight_editor/producer_freight_editor_controller.dart';
// import 'package:storetools/utils/log_utils.dart';
// import 'package:storetools/utils/toast_utils.dart';
//
// import '../../../entity/producer/producer_category_entity.dart';
// import '../../../widget/text_input_widget.dart';
//
// class ProducerFreightSpecPage extends BottomSheetPage {
//   const ProducerFreightSpecPage({super.key});
//
//   @override
//   BottomSheetState<BasePage> createBottomSheetState() => ProducerFreightSpecState();
// }
//
// class ProducerFreightSpecState extends BottomSheetState<ProducerFreightSpecPage> {
//   final _controller = Get.find<ProducerFreightEditorController>();
//   final _inputController = TextEditingController(text: "0");
//   late List<ProducerSkuWrapper> _skuWrappers;
//
//   @override
//   void initState() {
//     super.initState();
//     _initData();
//   }
//
//   _initData() {
//     _skuWrappers = ProducerSkuEntity.fromCategories(_controller.producer.categories)
//         .map((e) => ProducerSkuWrapper(isSelect: false, sku: e))
//         .toList();
//   }
//
//   List<String> generateSkus(List<ProducerCategoryEntity> categories, { List<String>? skus }) {
//     logDebug("开始匹配 skus:${jsonEncode(skus)} categories:${jsonEncode(categories)}");
//     if (categories.isEmpty) return [];
//     List<String> newSkus = [];
//     final category = categories.first;
//     if (skus.isNullOrEmpty()) {
//       newSkus.addAll(category.specs.map((e) => e.name));
//     } else {
//       logDebug("调试 skus:${jsonEncode(skus)} specs:${jsonEncode(category.specs)}");
//       for (var sku in skus!) {
//         for (var spec in category.specs) {
//           newSkus.add("$sku ${spec.name}");
//         }
//       }
//     }
//     if (categories.length > 1) {
//       return generateSkus(categories.sublist(1), skus: newSkus);
//     }
//     return newSkus;
//   }
//
//   @override
//   CustomScrollView buildScroll(BuildContext context, ScrollController controller) {
//     return CustomScrollView(
//       controller:  controller,
//       slivers: [
//         SliverAppBar(
//           title: const Text('指定规格运费'),
//           floating: true,
//           pinned: true,
//           actions: [
//             TextButton(
//                 onPressed: () => _save(),
//                 child: const Text('保存')
//             )
//           ],
//         ),
//         SliverToBoxAdapter(
//           child: TextInputWidget.number(controller: _inputController, label: '价格'),
//         ),
//         SliverList(
//             delegate: SliverChildListDelegate(_skuWrappers.mapIndex((index, e) => _buildSpecWrapper(index, e)) ?? [])
//         )
//       ],
//     );
//   }
//
//   Widget _buildSpecWrapper(int index, ProducerSkuWrapper wrapper) => GestureDetector(
//     onTap: () {
//       setState(() {
//         wrapper.isSelect = !wrapper.isSelect;
//         _skuWrappers.setSafe(index, wrapper);
//       });
//     },
//     child: Container(
//       color: Colors.transparent,
//       padding: const EdgeInsets.only(left: 10, right: 10),
//       height: 40,
//       child: Row(
//         children: [
//           Icon(wrapper.isSelect? Icons.check_box: Icons.check_box_outline_blank, size: 20),
//           Text(wrapper.sku.name)
//         ],
//       ),
//     ),
//   );
//
//   _save() {
//     final selectedSpecWrappers = _skuWrappers.filter((element) => element.isSelect);
//     if (selectedSpecWrappers.isNullOrEmpty()) {
//       showToast('未选择任何规格');
//       return;
//     }
//     final skuFreight = SkuFreightEntity()
//       ..extraPrice = double.parse(_inputController.text.trim())
//       ..skus = selectedSpecWrappers?.map((e) => e.sku).toList() ?? [];
//     _controller.addSkuFreight(skuFreight);
//     Get.back();
//   }
// }
//
// class ProducerSkuWrapper {
//   bool isSelect;
//   ProducerSkuEntity sku;
//
//   ProducerSkuWrapper({ required this.isSelect, required this.sku });
// }