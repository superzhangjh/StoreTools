import 'package:flutter/material.dart';
import 'package:storetools/base/base_page.dart';

class MineFragment extends BasePage {
  const MineFragment({super.key});

  @override
  State<StatefulWidget> createState() {
    return MineState();
  }
}

class MineState extends BaseState<MineFragment> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("我的"),
    );
  }
}