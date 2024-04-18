import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/ui/home/home_fragment.dart';
import 'package:storetools/ui/home/mine_fragment.dart';
import 'package:storetools/user/user_kit.dart';
import 'package:storetools/utils/toast_utils.dart';
import 'package:storetools/widget/loading_view.dart';
import 'package:storetools/widget/once_future_builder.dart';

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

  @override
  Widget build(BuildContext context) {
    return _buildPop(
        context: context, 
        child: OnceFutureBuilder<String?>(
            future: UserKit.getShopId(), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingView();
              }
              return _buildScaffold(context, snapshot.data);
            }
        )
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
  
  Widget _buildScaffold(BuildContext context, String? shopId) {
    var fragments = <Widget>[];
    if (shopId?.isNotEmpty == true) {
      fragments.add(const HomeFragment());
    } else {
      fragments.add(const EmptyShopFragment());
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("首页"),
        ),
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
    );
  }
}