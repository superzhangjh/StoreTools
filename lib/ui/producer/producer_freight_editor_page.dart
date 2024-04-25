import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/const/provinces.dart';
import 'package:storetools/entity/freight/freight_entity.dart';
import 'package:storetools/entity/producer/producer_detail_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ui/producer/producer_freight_editor_controller.dart';
import 'package:storetools/utils/dialog_utils.dart';
import 'package:storetools/utils/province_utils.dart';
import 'package:storetools/utils/toast_utils.dart';
import 'package:storetools/widget/text_input_widget.dart';

Future<List<FreightEntity>?> showFreightEditor(
    BuildContext context,
    ProducerDetailEntity producer,
    { int? selectedIndex }
) => showModalBottomSheet<List<FreightEntity>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    builder: (context) {
      return ProducerFreightEditorPage(producer: producer, selectedIndex: selectedIndex);
    }
);

class ProducerFreightEditorPage extends StatelessWidget {
  final ProducerDetailEntity producer;
  final int? selectedIndex;
  final _nameInputController = TextEditingController();
  final _priceInputController = TextEditingController();

  late final _controller = Get.put(ProducerFreightEditorController(producer: producer, selectedIndex: selectedIndex));

  ProducerFreightEditorPage({super.key, required this.producer, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 1,
        expand: false,
        builder: (context, controller) {
          return Container(
            color: Colors.white,
            child: CustomScrollView(
              controller: controller,
              slivers: [
                SliverAppBar(
                  title: const Text('阶梯运费'),
                  floating: true,
                  pinned: true,
                  actions: [
                    TextButton(
                        onPressed: () {
                          // _save
                        },
                        child: const Text('保存')
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: TextInputWidget(
                      controller: _nameInputController,
                      label: '名称(选填)'
                  ),
                ),
                SliverToBoxAdapter(
                  child: TextInputWidget(
                      controller: _priceInputController,
                      keyboardType: TextInputType.number,
                      label: '价格'
                  ),
                ),
                // SliverList(
                //     delegate: SliverChildListDelegate(
                //         _selectFreight.categoryPrices?.map((e) => null).toList()
                //     )
                // ),
                SliverToBoxAdapter(
                  child: TextButton(
                    onPressed: () => {

                    },
                    child: const Text('指定规格运费'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Obx(() => Wrap(
                    children: _controller.provinceWrappers.map((e) => _buildProvince(e)).toList(),
                  )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProvince(ProvinceWrapper provinceWrapper) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: TextButton(
        onPressed: () {
          // setState(() {
          //   if (provinceWrapper.enable) {
          //     provinceWrapper.selected = !provinceWrapper.selected;
          //   } else {
          //     _showMakeEnableDialog(provinceWrapper.provinceCode);
          //   }
          // })
        },
        style: TextButton.styleFrom(
            backgroundColor: provinceWrapper.enable? (provinceWrapper.selected? Colors.amber: Colors.transparent): Colors.grey,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            textStyle: TextStyle(
              color: provinceWrapper.selected || !provinceWrapper.enable? Colors.white: Colors.black54,
            )
        ),
        child: Text(ProvinceUtils.getInstance().getNameByCode(provinceWrapper.provinceCode) ?? ""),
      ),
    );
  }
}

// class ProducerFreightEditorState extends BaseState<ProducerFreightEditorPage> {
//
//   late List<FreightEntity> _freights;
//   late FreightEntity _selectFreight;
//   late TextEditingController _nameInputController;
//   late TextEditingController _priceInputController;
//   var _provinceWrappers = <ProvinceWrapper>[];
//
//   @override
//   void initState() {
//     _initData();
//     super.initState();
//   }
//
//   _initData() {
//     _freights = widget.freights?.map((e) => e.fromJson(e.toJson())).toList() ?? [];
//     if (widget.selectedIndex == null) {
//       _selectFreight = FreightEntity();
//       _freights.add(_selectFreight);
//     } else {
//       _selectFreight = _freights[widget.selectedIndex!];
//     }
//     _nameInputController = TextEditingController(text: _selectFreight.name);
//     _priceInputController = TextEditingController(text: (_selectFreight.price).toString());
//     _initProvinceWrappers();
//   }
//
//   _initProvinceWrappers() {
//     _provinceWrappers = Province.values.map((e) {
//       final code = e.name;
//       final selected = _selectFreight.provinceCodes?.contains(code) ?? false;
//       final enable = selected || (_freights.find((element) => element != _selectFreight && element.provinceCodes?.contains(code) == true) == null);
//       return ProvinceWrapper(provinceCode: code, selected: selected, enable: enable);
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
//
//   Widget _buildProvince(ProvinceWrapper provinceWrapper) {
//     return Padding(
//       padding: const EdgeInsets.all(2),
//       child: TextButton(
//         onPressed: () => setState(() {
//           if (provinceWrapper.enable) {
//             provinceWrapper.selected = !provinceWrapper.selected;
//           } else {
//             _showMakeEnableDialog(provinceWrapper.provinceCode);
//           }
//         }),
//         style: TextButton.styleFrom(
//           backgroundColor: provinceWrapper.enable? (provinceWrapper.selected? Colors.amber: Colors.transparent): Colors.grey,
//           padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//           textStyle: TextStyle(
//             color: provinceWrapper.selected || !provinceWrapper.enable? Colors.white: Colors.black54,
//           )
//         ),
//         child: Text(ProvinceUtils.getInstance().getNameByCode(provinceWrapper.provinceCode) ?? ""),
//       ),
//     );
//   }
//
//   _showMakeEnableDialog(String provinceCode) {
//     var useFreight = _freights.find((element) => element != _selectFreight && element.provinceCodes?.contains(provinceCode) == true);
//     if (useFreight != null) {
//       showConfirmDialog(context, '已被${useFreight.name}使用了，是否修改?', onPositiveClick: () {
//         final useIndex = _freights.indexOf(useFreight);
//         if (useIndex >= 0) {
//           setState(() {
//             useFreight.provinceCodes?.remove(provinceCode);
//             _selectFreight.provinceCodes?.add(provinceCode);
//             _freights.setSafe(useIndex, useFreight);
//             _initProvinceWrappers();
//           });
//           showToast('修改成功');
//         } else {
//           showToast('修改失败');
//         }
//         return true;
//       });
//     }
//   }
//
//   _save() {
//     var name = _nameInputController.text.trim();
//     if (name.isEmpty) name = '默认运费${DateTime.now().millisecondsSinceEpoch}';
//     _selectFreight
//       ..name = name
//       ..price = double.parse(_priceInputController.text.trim())
//       ..provinceCodes = _provinceWrappers.filter((e) => e.selected)?.map((e) => e.provinceCode).toList();
//     Navigator.pop(context, _freights);
//   }
// }

