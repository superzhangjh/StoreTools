import 'package:get/get.dart';
import 'package:storetools/api/apis.dart';
import 'package:storetools/entity/binding/goods_producer_binding_entity.dart';
import 'package:storetools/entity/goods/goods_entity.dart';
import 'package:storetools/entity/producer/producer_detail_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/utils/toast_utils.dart';

import '../../api/api.dart';
import '../../base/base_controller.dart';
import '../../route/route_arguments.dart';
import '../../utils/route_arguments_utils.dart';

class GoodsProducerBindingController extends BaseController {
  late final goodsId = getArgument<String>(RouteArguments.bindGoodsId);
  late final producer = getArgument<ProducerDetailEntity>(RouteArguments.producer);
  GoodsProducerBindingEntity? bindingEntity;
  final goodsEntity = Rx<GoodsEntity?>(null);
  final skuBindings = <SkuBindingWrapper>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchGoodsDetail();
  }

  // _requestBounds() async {
  //   var result = await Api.whereEqualTo();
  //   if (result.isSuccess()) {
  //     producers.value = result.data ?? [];
  //   } else {
  //     showToast(result.msg);
  //   }
  // }

  _fetchGoodsDetail() async {
    if (goodsId?.isNotEmpty == true) {
      var result = await Api.whereEqualTo(GoodsEntity(), Apis.lcFieldObjectId, goodsId);
      if (result.isSuccess()) {
        goodsEntity.value = result.data?.getSafeOfNull(0);
      } else {
        showToast(result.msg);
      }
    } else {
      showToast("商品id不存在");
      Get.back();
    }
  }
}

class SkuBindingWrapper {
  bool bound;
  String name;

  SkuBindingWrapper({ required this.bound, required this.name });
}