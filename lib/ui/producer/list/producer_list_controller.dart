import 'package:get/get.dart';
import 'package:storetools/base/base_controller.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ext/string_ext.dart';
import 'package:storetools/route/route_arguments.dart';
import 'package:storetools/utils/route_arguments_utils.dart';

import '../../../api/api.dart';
import '../../../entity/producer/producer_detail_entity.dart';
import '../../../route/route_kit.dart';
import '../../../route/route_result.dart';
import '../../../utils/toast_utils.dart';

class ProducerListController extends BaseController {
  final producers = <ProducerDetailEntity>[].obs;
  late final bindGoodsId = getArgument<String>(RouteArguments.bindGoodsId);

  @override
  void onInit() {
    super.onInit();
    _requestProducers();
  }

  _requestProducers() async {
    var result = await Api.queryAll(ProducerDetailEntity());
    if (result.isSuccess()) {
      producers.value = result.data ?? [];
    } else {
      showToast(result.msg);
    }
  }

  editProducer(int index) async {
    final result = await RouteKit.toProducerEditor(producer: producers[index]);
    switch (result.code) {
      case RouteResult.resultOk:
        producers.setSafe(index, result.data);
        break;
      case RouteResult.resultDelete:
        producers.removeAtSafe(index);
        break;
    }
  }

  createProducer() async {
    final result = await RouteKit.toProducerEditor();
    if (result.code == RouteResult.resultOk) {
      producers.addOrIgnore(result.data);
    }
  }


  ///绑定商品
  bindGoods(ProducerDetailEntity producer) {
    if (bindGoodsId?.isNotEmpty == true) {
      RouteKit.toProducerBinding(bindGoodsId!, producer);
    } else {
      //todo:选择商品列表去绑定
    }
  }
}