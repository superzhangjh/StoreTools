import 'package:storetools/entity/binding/goods_producer_binding_entity.dart';
import 'package:storetools/entity/producer/producer_detail_entity.dart';

import '../../api/api.dart';
import '../../base/base_controller.dart';
import '../../route/route_arguments.dart';
import '../../utils/route_arguments_utils.dart';

class GoodsProducerBindingController extends BaseController {
  late final goodsId = getArgument<String>(RouteArguments.bindGoodsId);
  late final producer = getArgument<ProducerDetailEntity>(RouteArguments.producer);
  GoodsProducerBindingEntity? bindingEntity;

  // _requestBounds() async {
  //   var result = await Api.whereEqualTo();
  //   if (result.isSuccess()) {
  //     producers.value = result.data ?? [];
  //   } else {
  //     showToast(result.msg);
  //   }
  // }


}