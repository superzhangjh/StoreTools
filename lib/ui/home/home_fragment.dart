import 'package:flutter/material.dart';
import 'package:storetools/base/base_page.dart';

class HomeFragment extends BasePage {
  const HomeFragment({super.key});

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