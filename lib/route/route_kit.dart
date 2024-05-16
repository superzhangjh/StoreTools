import 'dart:async';

import 'package:get/get.dart';
import 'package:storetools/route/route_paths.dart';
import 'package:storetools/route/route_result.dart';
import 'package:storetools/ui/goods_producer_binding/goods_producer_binding_page.dart';

import 'route_arguments.dart';
import '../entity/producer/producer_detail_entity.dart';

class RouteKit {
  RouteKit._();

  ///跳转应用
  ///[routeName]跳转路径
  ///[arguments]携带参数
  ///[off]跳转后是否关闭当前的页面
  static FutureOr<RouteResult<T>> navigate<T>(String routeName, { dynamic arguments, bool? offPage }) async {
    final data = await (offPage != true? Get.toNamed(routeName, arguments: arguments): Get.offNamed(routeName, arguments: arguments));
    if (data is RouteResult) {
      return data as RouteResult<T>;
    }
    return RouteResult(data: data as T);
  }

  ///货源列表
  ///[goodsId]需要绑定的商品id
  static Future<RouteResult> toProducerList({ String? goodsId }) async {
    return RouteKit.navigate(RoutePaths.goodsList, arguments: {
      RouteArguments.bindGoodsId: goodsId,
    });
  }

  ///货源编辑
  static Future<RouteResult<ProducerDetailEntity>> toProducerEditor({ ProducerDetailEntity? producer }) async {
    return RouteKit.navigate<ProducerDetailEntity>(RoutePaths.producerEditor, arguments: { RouteArguments.producer: producer });
  }

  ///货源绑定
  static Future<RouteResult> toProducerBinding(String goodsId, ProducerDetailEntity producer) async {
    return RouteKit.navigate<GoodsProducerBindingPage>(RoutePaths.goodsProducerBinding, arguments: {
      RouteArguments.bindGoodsId: goodsId,
      RouteArguments.producer: producer
    });
  }
}