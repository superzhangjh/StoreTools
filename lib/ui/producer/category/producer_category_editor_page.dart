import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/base/bottom_sheet_page.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/entity/producer/producer_tag_entity.dart';
import 'package:storetools/ext/text_editing_controller_ext.dart';
import 'package:storetools/ui/producer/producer_editor_controller.dart';
import 'package:storetools/utils/dialog_utils.dart';
import 'package:storetools/utils/toast_utils.dart';
import '../../../utils/short_uuid_utils.dart';
import '../../../widget/text_input_widget.dart';

class ProducerCategoryEditorPage extends BottomSheetPage {
  final ProducerCategoryEntity? categoryEntity;

  const ProducerCategoryEditorPage({super.key, this.categoryEntity});

  @override
  BottomSheetState<BasePage> createBottomSheetState() => ProducerCategoryEditorState();
}

class ProducerCategoryEditorState extends BottomSheetState<ProducerCategoryEditorPage> {
  final _controller = Get.find<ProducerEditorController>();
  late final _category = widget.categoryEntity;
  late final _isCreate = _category == null;
  late final _nameController = TextEditingController(text: _category?.name);
  late final _tags = (_category?.tags ?? []).obs;

  @override
  CustomScrollView buildScroll(BuildContext context, ScrollController controller) {
    return CustomScrollView(
      controller:  controller,
      slivers: [
        SliverAppBar(
          title: Text(_isCreate? '新建分类': '编辑分类'),
          floating: true,
          pinned: true,
          actions: [
            Offstage(
              offstage: _isCreate,
              child: TextButton(
                  onPressed: () => _controller.deleteCategory(_category),
                  child: const Text('删除')
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
        Obx(() => SliverList(
            delegate: SliverChildListDelegate(_tags.map(_buildTag).toList())
        )),
        SliverToBoxAdapter(
          child: TextButton(
            onPressed: _createTag,
            child: const Text('新建标签'),
          ),
        )
      ],
    );
  }

  Widget _buildTag(ProducerTagEntity tagEntity) => Row(
    children: [
      Text(tagEntity.name),
      IconButton(
          onPressed: () => _tags.remove(tagEntity),
          icon: const Icon(Icons.delete_forever)
      )
    ],
  );

  _createTag() {
    showInputDialog(context, '新建标签', '标签名称', (text) {
      final tag = ProducerTagEntity()
        ..id = ShortUUidUtils.generateShortId()
        ..name = text;
      _tags.add(tag);
      return true;
    });
  }

  _save() async {
    if (await _controller.createOrUpdateCategory(_category, _nameController.stringValue(), _tags)) {
      Get.back();
    } else {
      showToast(_isCreate? '创建失败': '编辑失败');
    }
  }
}
