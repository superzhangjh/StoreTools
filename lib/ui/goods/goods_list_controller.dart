import 'package:get/get.dart';
import 'package:storetools/base/base_controller.dart';
import 'package:storetools/entity/binding/goods_producer_binding_entity.dart';

import '../../api/api.dart';
import '../../api/apis.dart';
import '../../entity/goods/goods_entity.dart';
import '../../route/route_kit.dart';
import '../../route/route_paths.dart';
import '../../user/user_kit.dart';
import '../../utils/toast_utils.dart';

class GoodsListController extends BaseController {
  final goodsEntities = <GoodsEntity>[].obs;
  final goodsProducerBinding = <GoodsProducerBindingEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getBounds();
    _getGoodsList();
  }

  _getBounds() async {
    var result = await Api.queryAll(GoodsProducerBindingEntity());
    if (result.isSuccess()) {
      // goodsProducerBinding
    } else {
      showToast(result.msg);
    }
  }

  ///请求商品列表
  _getGoodsList() async {
    var shopId = await UserKit.getShopId();
    var result = await Api.whereEqualTo(GoodsEntity(), Apis.lcFieldObjectId, shopId);
    if (result.isSuccess()) {
      goodsEntities.value = result.data ?? [];
    } else {
      showToast(result.msg);
    }
  }

  ///去绑定货源
  toBindProducer() {
    RouteKit.navigate(RoutePaths.producerList);
  }
}