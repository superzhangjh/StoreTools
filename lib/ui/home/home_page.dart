import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storetools/api/api.dart';
import 'package:storetools/api/entity/api_entity.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/const/apis.dart';
import 'package:storetools/entity/shop_entity.dart';
import 'package:storetools/ext/list_ext.dart';
import 'package:storetools/ui/home/home_fragment.dart';
import 'package:storetools/ui/home/mine_fragment.dart';
import 'package:storetools/user/user_kit.dart';
import 'package:storetools/utils/toast_utils.dart';

import 'empty_shop_fragment.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends BaseState<HomePage> {
  final _pageController = PageController();
  int _currentIndex = 0;
  int popTimestamp = 0;
  ShopEntity? _shopEntity;

  @override
  void initBuildContext(BuildContext context) async {
    super.initBuildContext(context);
    _refreshShop(await UserKit.getShopId());
  }

  @override
  Widget build(BuildContext context) {
    return _buildPop(
        context: context, 
        child: _buildScaffold(context)
    );
  }
  
  Widget _buildPop({ required BuildContext context, required Widget child }) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        var now = DateTime.now().millisecondsSinceEpoch;
        if (now - popTimestamp < 1000) {
          Navigator.of(context).popUntil((route) => false);
        } else {
          popTimestamp = now;
          showToast('再次返回将退出应用');
        }
      },
      child: child,
    );
  }
  
  Widget _buildScaffold(BuildContext context) {
    var shopEntity = _shopEntity;
    var fragments = <Widget>[];
    if (shopEntity?.objectId?.isNotEmpty == true) {
      fragments.add(HomeFragment(shopEntity: shopEntity!));
    } else {
      fragments.add(EmptyShopFragment(onShopChanged: _refreshShop));
    }
    fragments.add(const MineFragment());
    
    var barItems = <BottomNavigationBarItem>[];
    barItems.add(const BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.houseMedical),
        label: '首页'
    ));
    barItems.add(const BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.user),
        label: '我的'
    ));
    return SafeArea(
        child: Scaffold(
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: fragments,
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  _currentIndex = index;
                  _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                },
                items: barItems
            )
        )
    );
  }

  ///刷新店铺
  void _refreshShop(String? shopId) async {
    if (shopId == null) return;
    var result = await Api.whereEqualTo(ShopEntity(), Apis.lcFieldObjectId, shopId);
    if (result.isSuccess()) {
      var shops = result.data;
      log("查询到的店铺id:${jsonEncode(shops)}");
      setState(() {
        _shopEntity = shops?.getSafeOfNull(0);
      });
    } else {
      showToast(result.msg);
    }
  }
}