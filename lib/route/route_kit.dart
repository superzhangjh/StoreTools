import 'dart:async';

import 'package:get/get.dart';
import 'package:storetools/route/route_paths.dart';
import 'package:storetools/route/route_result.dart';

import '../const/arguments.dart';
import '../entity/producer/producer_detail_entity.dart';

class RouteKit {
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

  // static toGoodsPreview() {
  //
  // }

  ///货源编辑
  static Future<RouteResult<ProducerDetailEntity>> toProducerEditor({ ProducerDetailEntity? producer }) async {
    return RouteKit.navigate<ProducerDetailEntity>(RoutePaths.producerEditor, arguments: { Arguments.producer: producer });
  }
}