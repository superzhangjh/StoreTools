import 'package:flutter/material.dart';
import 'package:storetools/base/base_page.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends BaseState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首页"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {

                },
                child: const Text("创建店铺")
            ),
            TextButton(
                onPressed: () {

                },
                child: const Text("加入店铺")
            ),
          ],
        ),
      ),
    );
  }

}