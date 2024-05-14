import 'package:flutter/material.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/entity/shop_entity.dart';
import 'package:storetools/route/route_kit.dart';
import 'package:storetools/route/route_paths.dart';

class HomeFragment extends BasePage {
  final ShopEntity shopEntity;

  const HomeFragment({super.key, required this.shopEntity});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends BaseState<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: Colors.amber,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("店铺：${widget.shopEntity.name}"),
              TextButton(
                  onPressed: () => RouteKit.navigate(RoutePaths.goodsList),
                  child: const Text('商品列表')
              ),
              TextButton(
                  onPressed: () => RouteKit.navigate(RoutePaths.producerHome),
                  child: const Text('货源管理')
              ),
            ]),
        )
    );
  }
}