import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/const/routes.dart';

class SplashPage extends BasePage {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends BaseState<SplashPage> {
  @override
  void initBuildContext(BuildContext context) {
    super.initBuildContext(context);
    _initUser();
  }

  _initUser() async {
    var currentUser = await LCUser.getCurrent();
    print("当前用户: $currentUser");
    if (currentUser != null) {
      await Navigator.pushNamed(context, Routes.home);
    } else {
      await Navigator.pushNamed(context, Routes.login);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset('assets/images/icon_launcher.png'),
        ),
      ),
    );
  }

}