import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/base/base_page.dart';
import 'package:storetools/route/route_kit.dart';
import 'package:storetools/route/route_paths.dart';
import 'package:storetools/utils/log_utils.dart';

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
    logDebug("当前用户: $currentUser");
    RouteKit.navigate(currentUser == null? RoutePaths.login: RoutePaths.home, offPage: true);
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