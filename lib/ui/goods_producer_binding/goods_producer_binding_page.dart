import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/ui/goods_producer_binding/entity/sku_category_bindable.dart';
import 'package:storetools/ui/goods_producer_binding/goods_producer_binding_controller.dart';

import 'entity/sku_spec_bindable.dart';

class GoodsProducerBindingPage extends BasePage {
  const GoodsProducerBindingPage({super.key});

  @override
  State<StatefulWidget> createState() => GoodsProducerBindingState();
}

class GoodsProducerBindingState extends BaseState<GoodsProducerBindingPage> {
  late final _controller = Get.put(GoodsProducerBindingController());

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverAppBar(
        title: const Text('绑定货源'),
        floating: true,
        pinned: true,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text('保存')
          )
        ],
      ),
      Obx(() => SliverList(
        delegate: SliverChildListDelegate(_controller.skuCategoryBindalbes.map(_buildCategoryBindables).toList()),
      ))
    ],
  );

  Widget _buildCategoryBindables(SkuCategoryBindable bindable) {
    return Column(
      children: [
        Text(bindable.name),
        ...bindable.specs.map(_buildSpecBindables)
      ],
    );
  }

  Widget _buildSpecBindables(SkuSpecBindable bindable) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(bindable.name),
    );
  }

  @override
  void dispose() {
    Get.delete<GoodsProducerBindingController>();
    super.dispose();
  }
}