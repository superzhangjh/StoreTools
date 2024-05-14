import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/ui/goods_producer_binding/goods_producer_binding_controller.dart';

class GoodsProducerBindingPage extends BasePage {
  const GoodsProducerBindingPage({super.key});

  @override
  State<StatefulWidget> createState() => GoodsProducerBindingState();
}

class GoodsProducerBindingState extends BaseState<GoodsProducerBindingPage> {
  late final _controller = Get.put(GoodsProducerBindingController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void dispose() {
    Get.delete<GoodsProducerBindingController>();
    super.dispose();
  }
}