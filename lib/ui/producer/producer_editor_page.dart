import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/base/bottom_sheet_page.dart';
import 'package:storetools/entity/freight/freight_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ext/string_ext.dart';
import 'package:storetools/route/route_result.dart';
import 'package:storetools/ui/producer/category/producer_category_editor_page.dart';
import 'package:storetools/ui/producer/freight_editor/producer_freight_editor_page.dart';
import 'package:storetools/ui/producer/producer_editor_controller.dart';
import 'package:storetools/ui/producer/category/producer_spec_editor_page.dart';
import 'package:storetools/utils/dialog_utils.dart';
import 'package:storetools/utils/log_utils.dart';
import 'package:storetools/widget/text_input_widget.dart';

import '../../entity/producer/producer_category_entity.dart';
import '../../entity/producer/producer_spec_entity.dart';
import '../../widget/icon_text_button.dart';

///货源编辑
class ProducerEditorPage extends BasePage {
  const ProducerEditorPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProducerEditorState();
  }
}

class ProducerEditorState extends BaseState<ProducerEditorPage> {
  late final _controller = Get.put(ProducerEditorController());
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    logDebug("使用阶梯运费：${_controller.producer.value.useStepFreight}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('货源编辑'),
        actions: [
          Offstage(
            offstage: _controller.producer.value.objectId.isNullOrEmpty(),
            child: TextButton(
              onPressed: _controller.delete,
              child: const Text('删除'),
            ),
          ),
          TextButton(
            onPressed: _controller.save,
            child: const Text('保存'),
          )
        ]
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: TextInputWidget(controller: _controller.nameController, label: '名称'),
          ),
          Obx(() => SliverList(
            delegate: SliverChildListDelegate(_controller.producer.value.categories.map((element) => _buildCategory(element)).toList()),
          )),
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () {
                bottomSheetPage(const ProducerCategoryEditorPage());
              },
              child: const Text('新增分类'),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('运费：'),
                Expanded(child: _buildFreightRatio('统一运费', false)),
                Expanded(child: _buildFreightRatio('阶梯运费', true))
              ],
            ),
          ),
          Obx(() => SliverToBoxAdapter(
            child: Offstage(
              offstage: _controller.producer.value.useStepFreight || _controller.producer.value.freight == null,
              child: _buildFreight(_controller.producer.value.freight, false),
            ),
          )),
          Obx(() {
            logDebug("阶梯运费: ${_controller.producer.value.stepFreights}");
            return SliverList(
                delegate: SliverChildListDelegate(
                    _controller.producer.value.stepFreights?.mapIndex((index, element) => Offstage(
                      offstage: !_controller.producer.value.useStepFreight,
                      child: _buildFreight(element, true, index: index),
                    )) ?? []
                )
            );
          }),
          Obx(() {
            final useStepFreight = _controller.producer.value.useStepFreight;
            return SliverToBoxAdapter(
              child: Offstage(
                offstage: !useStepFreight && _controller.producer.value.freight != null,
                child: TextButton(
                  onPressed: () => _controller.showFreightEditor(useStepFreight),
                  child: const Text('新增运费'),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _buildCategory(ProducerCategoryEntity category) {
    return Column(
      children: [
        TextButton(
            onPressed: () => bottomSheetPage(ProducerCategoryEditorPage(categoryEntity: category)),
            child: Text(category.name)
        ),
        ...?category.specs.mapIndex((index, e) => _buildSpec(category, e, index)),
        IconTextButton(
            onPressed: () => bottomSheetPage(ProducerSpecPage(categoryEntity: category)),
            text: '新增规格',
            icon: Icons.add
        ),
      ],
    );
  }

  Widget _buildSpec(ProducerCategoryEntity category, ProducerSpecEntity specEntity, int index) {
    return TextButton(
        onPressed: () => bottomSheetPage(ProducerSpecPage(categoryEntity: category, specIndex: index)), 
        child: Text(specEntity.name)
    );
  }

  Widget _buildFreightRatio(String title, bool value) => Obx(() => GestureDetector(
    onTap: () => _controller.toggleUseStepFreight(value),
    child: Row(
      children: [
        Icon(_controller.producer.value.useStepFreight == value? Icons.radio_button_checked: Icons.radio_button_off),
        Text(title)
      ],
    ),
  ));

  Widget _buildFreight(FreightEntity? freightEntity, bool useStepFreight, { int? index }) {
    return TextButton(
      onPressed: () => _controller.showFreightEditor(useStepFreight, index: index),
      child: Text("${freightEntity?.name}  运费:${freightEntity?.price}"),
    );
  }

  @override
  void dispose() {
    Get.delete<ProducerEditorController>();
    super.dispose();
  }
}