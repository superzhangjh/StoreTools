import 'package:flutter/material.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/const/routes.dart';
import 'package:storetools/entity/shop_entity.dart';

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
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.goods);
                  },
                  child: const Text('商品列表')
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.producerHome);
                  },
                  child: const Text('货源管理')
              ),
            ]),
        )
    );
  }
}