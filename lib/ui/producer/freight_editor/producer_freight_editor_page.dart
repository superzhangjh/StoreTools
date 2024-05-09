import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/base/bottom_sheet_page.dart';
import 'package:storetools/entity/freight/tag_freight_entity.dart';
import 'package:storetools/entity/producer/producer_detail_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ui/producer/freight_editor/producer_freight_editor_controller.dart';
import 'package:storetools/utils/province_utils.dart';
import 'package:storetools/widget/text_input_widget.dart';

class ProducerFreightEditorPage extends BottomSheetPage {
  final ProducerDetailEntity producer;
  final bool useStepFreight;
  final int? selectedStepIndex;

  const ProducerFreightEditorPage({super.key, required this.producer, required this.useStepFreight, this.selectedStepIndex});

  @override
  BottomSheetState<BasePage> createBottomSheetState() => ProducerFreightEditorState();
}

class ProducerFreightEditorState extends BottomSheetState<ProducerFreightEditorPage> {

  late final _controller = Get.put(ProducerFreightEditorController(
      producer: widget.producer,
      useStepFreight: widget.useStepFreight,
      selectedStepIndex: widget.selectedStepIndex
  ));

  @override
  CustomScrollView buildScroll(BuildContext context, ScrollController controller) => CustomScrollView(
    controller: controller,
    slivers: [
      SliverAppBar(
        title: const Text('阶梯运费'),
        floating: true,
        pinned: true,
        actions: [
          TextButton(
              onPressed: _controller.save,
              child: const Text('保存')
          )
        ],
      ),
      SliverToBoxAdapter(
        child: Offstage(
          offstage: widget.useStepFreight,
          child: TextInputWidget(
              controller: _controller.nameInputController,
              label: '名称(选填)'
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: TextInputWidget(
            controller: _controller.priceInputController,
            keyboardType: TextInputType.number,
            label: '价格'
        ),
      ),
      Obx(() => SliverList(
          delegate: SliverChildListDelegate(_controller.tagFreights.mapIndex(_buildTagFreight) ?? [])
      )),
      // Obx(() => SliverFixedExtentList(
      //     delegate: SliverChildListDelegate(_controller.tagFreightWrappers.mapIndex(_buildTagFreight) ?? []),
      //     itemExtent: 50
      // )),
      SliverToBoxAdapter(
        child: Obx(() => Offstage(
          offstage: !widget.useStepFreight,
          child: Wrap(
            children: _controller.provinceWrappers.map((e) => _buildProvince(e)).toList(),
          ),
        )),
      )
    ],
  );

  Widget _buildTagFreight(int index, TagFreightEntity tagFreight) {
    return TextInputWidget.number(
        controller: _controller.tagFreightControllerMap[tagFreight.tag?.id ?? '']!,
        label: '${tagFreight.tag?.name}价格（选填）'
    );
  }

  Widget _buildProvince(ProvinceWrapper provinceWrapper) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: TextButton(
        onPressed: () => _controller.triggerProvinceClick(provinceWrapper),
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

  @override
  void dispose() {
    Get.delete<ProducerFreightEditorController>();
    super.dispose();
  }
}

