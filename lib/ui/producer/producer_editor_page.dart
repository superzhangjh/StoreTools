import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/const/arguments.dart';
import 'package:storetools/const/provinces.dart';
import 'package:storetools/entity/freight/freight_entity.dart';
import 'package:storetools/entity/producer/producer_category_entity.dart';
import 'package:storetools/entity/producer/producer_detail_entity.dart';
import 'package:storetools/entity/producer/producer_spec_entity.dart';
import 'package:storetools/entity/province_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ui/producer/producer_freight_editor_page.dart';
import 'package:storetools/utils/dialog_utils.dart';
import 'package:storetools/utils/toast_utils.dart';
import 'package:storetools/widget/loading_view.dart';
import 'package:storetools/widget/text_input_widget.dart';

import '../../api/api.dart';
import '../../utils/route_arguments_utils.dart';
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
  ProducerDetailEntity? _producer;
  final _nameController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initBuildContext(context) {
    _initProducer();
  }

  _initProducer() async {
    setState(() {
      _producer = getArgument(context, Arguments.producer) ?? ProducerDetailEntity();
      _nameController.text = _producer!.name ?? "";
      log("接收:${jsonEncode(_producer)}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('货源编辑'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('保存'),
          )
        ]
      ),
      body: _producer == null? const LoadingView(): CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: TextInputWidget(controller: _nameController, label: '名称'),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ..._producer!.categories.map((e) => _buildCategory(e))
            ]),
          ),
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () {
                showInputDialog(context, '新增分类', '名称', _createCategory);
              },
              child: const Text('新增分类'),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('运费：'),
                _buildFreightRatio('全国包邮', false),
                _buildFreightRatio('阶梯运费', true),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ..._producer!.freights?.map((e) => Offstage(
                offstage: !_producer!.useFreight,
                child: _buildFreight(e),
              )) ?? []
            ]),
          ),
          SliverToBoxAdapter(
            child: Offstage(
              offstage: !_producer!.useFreight,
              child: TextButton(
                onPressed: () => _showFreightEditor(),
                child: const Text('新增运费'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategory(ProducerCategoryEntity category) {
    return Column(
      children: [
        Text(category.name),
        ...category.specs?.map((e) => _buildSpec(e)) ?? [],
        IconTextButton(
            onPressed: () {
              showInputDialog(context, '新增规格', '名称(选填)', (text) {
                return _createSpec(category, text);
              });
            },
            text: '新增规格',
            icon: Icons.add
        ),
      ],
    );
  }

  Widget _buildSpec(ProducerSpecEntity specEntity) {
    return Text(specEntity.name);
  }

  Widget _buildFreightRatio(String title, bool value) {
    return Row(
      children: [
        Radio(
            value: value,
            groupValue: _producer!.useFreight,
            onChanged: (newValue) => setState(() {
              _producer!.useFreight = value;
            })
        ),
        Text(title)
      ],
    );
  }

  Widget _buildFreight(FreightEntity freightEntity) {
    return TextButton(
      onPressed: () => _showFreightEditor(freightEntity: freightEntity),
      child: Text("${freightEntity.name}  运费:${freightEntity.price}"),
    );
  }

  ///新建分类
  FutureOr<bool> _createCategory(String name) {
    var found = _producer!.categories.find((e) => e.name == name);
    if (found != null) {
      showToast('该分类已存在');
      return false;
    }
    var category = ProducerCategoryEntity();
    category.name = name;
    setState(() {
      _producer!.categories.add(category);
    });
    return true;
  }

  ///新建规格
  FutureOr<bool> _createSpec(ProducerCategoryEntity category, String name) {
    var found = category.specs?.find((e) => e.name == name);
    if (found != null) {
      showToast('该规格已存在');
      return false;
    }
    var spec = ProducerSpecEntity();
    spec.name = name;
    category.specs ??= [];
    category.specs!.add(spec);
    setState(() {
      var categoryIndex = _producer!.categories.findIndex((element) => element.name == category.name);
      _producer!.categories.setSafe(categoryIndex, category);
    });
    return true;
  }

  ///打开运费编辑
  ///[freightEntity]运费信息，不传则创建新的
  _showFreightEditor({ FreightEntity? freightEntity }) async {
    final newFreights = await showFreightEditor(
        context,
        _producer!,
        selectedIndex: freightEntity == null? null: _producer?.freights?.findIndex((element) => element == freightEntity)
    );
    if (newFreights != null) {
      setState(() {
        _producer?.freights = newFreights;
      });
    }
  }

  _save() async {
    var name = _nameController.text.trim();
    if (name.isEmpty) name = '货源${DateTime.now().millisecondsSinceEpoch}';
    if (_producer!.categories.isEmpty || _producer!.categories.find((e) => e.specs.isNullOrEmpty()) != null) {
      showToast('分类数据或者分类规格未填写，请检查后重试');
      return;
    }
    _producer!.name = name;
    var result = await Api.createOrUpdate(_producer!);
    if (result.isSuccess()) {
      showToast('保存成功');
      Navigator.pop(context, result.data);
    } else {
      showToast(result.msg);
    }
  }
}