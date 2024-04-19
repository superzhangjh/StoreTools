import 'package:flutter/material.dart';
import 'package:storetools/base/base_page.dart';
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
    return const Center(
      child: Text('首页'),
    );
  }
}