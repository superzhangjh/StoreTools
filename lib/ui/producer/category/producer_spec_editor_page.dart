import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/base/bottom_sheet_page.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/entity/producer/producer_tag_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ext/text_editing_controller_ext.dart';
import 'package:storetools/ui/producer/category/producer_category_editor_page.dart';
import 'package:storetools/ui/producer/producer_editor_controller.dart';
import 'package:storetools/utils/dialog_utils.dart';
import 'package:storetools/utils/log_utils.dart';
import 'package:storetools/widget/radio_button.dart';

import '../../../entity/selector_entity.dart';
import '../../../widget/text_input_widget.dart';

class ProducerSpecPage extends BottomSheetPage {
  final ProducerCategoryEntity categoryEntity;
  final int? specIndex;

  const ProducerSpecPage({super.key, required this.categoryEntity, this.specIndex});

  @override
  BottomSheetState<BasePage> createBottomSheetState() => ProducerSpecState();
}

class ProducerSpecState extends BottomSheetState<ProducerSpecPage> {
  final _controller = Get.find<ProducerEditorController>();
  late final _specEntity = widget.categoryEntity.specs.getSafeOfNull(widget.specIndex);
  late final _nameController = TextEditingController(text: _specEntity?.name);
  late final _priceController = TextEditingController(text: _specEntity?.cost.toString() );
  final tagSelectors = <SelectorEntity<ProducerTagEntity>>[].obs;

  @override
  void initState() {
    super.initState();
    _initTags();
  }

  _initTags() {
    tagSelectors.value = widget.categoryEntity.tags?.map((e) => SelectorEntity(
        isSelected: _specEntity?.tagId == e.id,
        data: e
    )).toList() ?? [];
  }

  @override
  CustomScrollView buildScroll(BuildContext context, ScrollController controller) {
    return CustomScrollView(
      controller:  controller,
      slivers: [
        SliverAppBar(
          title: Text(widget.specIndex == null? '新建规格': '编辑规格'),
          floating: true,
          pinned: true,
          actions: [
            Offstage(
              offstage: widget.specIndex == null,
              child: TextButton(
                onPressed: () => _controller.deleteSpec(widget.categoryEntity, widget.specIndex),
                child: const Text('删除'),
              ),
            ),
            TextButton(
                onPressed: _save,
                child: const Text('保存')
            )
          ],
        ),
        SliverToBoxAdapter(
          child: TextInputWidget(
            controller: _nameController,
            label: "名称",
          ),
        ),
        SliverToBoxAdapter(
          child: TextInputWidget.number(controller: _priceController, label: '价格'),
        ),
        SliverToBoxAdapter(
          child: Obx(() => Offstage(
            offstage: tagSelectors.isNullOrEmpty(),
            child: Column(
              children: [
                const Text('选择标签'),
                Wrap(
                  children: tagSelectors.map(_buildTag).toList(),
                )
              ],
            ),
          )),
        )
      ],
    );
  }

  Widget _buildTag(SelectorEntity<ProducerTagEntity> selectorEntity) {
    return RadioButton(
      title: selectorEntity.data.name,
      isChecked: selectorEntity.isSelected,
      onCheckChanged: () {
        final currentSelected = tagSelectors.find((element) => element.isSelected);
        if (currentSelected?.data.id == selectorEntity.data.id) {
          //点击的是当前的item，取消选中
          currentSelected?.isSelected = false;
        } else {
          //切换单选
          for (var element in tagSelectors) {
            element.isSelected = element.data.id == selectorEntity.data.id;
          }
        }
        tagSelectors.refresh();
      },
    );
  }

  _save() async {
    final name = _nameController.text.trim();
    final price = _priceController.doubleValue() ?? 0;
    final tagId = tagSelectors.find((element) => element.isSelected)?.data.id;
    if (await _controller.createOrUpdateSpec(widget.categoryEntity, widget.specIndex, name, price, tagId)) {
      Get.back();
    }
  }
}
