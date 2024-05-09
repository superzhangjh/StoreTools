import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/base/bottom_sheet_page.dart';
import 'package:storetools/entity/freight/freight_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ui/producer/freight_editor/producer_freight_editor_page.dart';
import 'package:storetools/ui/producer/producer_editor_controller.dart';
import 'package:storetools/ui/producer/producer_spec_page.dart';
import 'package:storetools/utils/dialog_utils.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('货源编辑'),
        actions: [
          TextButton(
            onPressed: () => _controller.save(),
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
                showInputDialog(context, '新增分类', '名称', _controller.createCategory);
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
          Obx(() => SliverList(
              delegate: SliverChildListDelegate(
                  _controller.producer.value.stepFreights?.mapIndex((index, element) => Offstage(
                    offstage: _controller.producer.value.useStepFreight,
                    child: _buildFreight(element, true, index: index),
                  )) ?? []
              ))),
          Obx(() {
            final useStepFreight = _controller.producer.value.useStepFreight;
            return SliverToBoxAdapter(
              child: Offstage(
                offstage: !useStepFreight && _controller.producer.value.freight != null,
                child: TextButton(
                  onPressed: () => _showFreightEditor(useStepFreight),
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
        Text(category.name),
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
      onPressed: () => _showFreightEditor(useStepFreight, index: index),
      child: Text("${freightEntity?.name}  运费:${freightEntity?.price}"),
    );
  }

  ///打开运费编辑
  ///[freightEntity]运费信息，不传则创建新的
  _showFreightEditor(bool useStepFreight, {int? index}) async {
    bottomSheetPage(ProducerFreightEditorPage(
        producer: _controller.producer.value,
        useStepFreight: useStepFreight,
        selectedStepIndex: index
    ));
  }

  @override
  void dispose() {
    Get.delete<ProducerEditorController>();
    super.dispose();
  }
}