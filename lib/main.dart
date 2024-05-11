import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/route/route_paths.dart';
import 'package:storetools/ui/goods_edit_page.dart';
import 'package:storetools/ui/goods/goods_page.dart';
import 'package:storetools/ui/goods_preview_page.dart';
import 'package:storetools/ui/home/home_page.dart';
import 'package:storetools/ui/login_page.dart';
import 'package:storetools/ui/producer/producer_editor_page.dart';
import 'package:storetools/ui/producer/producer_home_page.dart';
import 'package:storetools/ui/splash_page.dart';

import 'asyncTask/data/isolate_data.dart';

void main() async {
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  LeanCloud.initialize(
    "5vkS6rZ55Sw3NuSScCLU9v5B-gzGzoHsz",
    "E7oTgLfWMtVkI9YzeyXkGZXg",
    server: "https://5vks6rz5.lc-cn-n1-shared.com",
    queryCache: LCQueryCache()
  );
  LCLogger.setLevel(LCLogger.DebugLevel);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RoutePaths.splash,
      routes: {
        RoutePaths.splash: (_) => const SplashPage(),
        RoutePaths.login: (_) => const LoginPage(),
        RoutePaths.home: (_) => const HomePage(),
        RoutePaths.goods: (_) => const GoodsPage(),
        RoutePaths.goodsEdit: (_) => const GoodsEditPage(),
        RoutePaths.goodsPreview: (_) => const GoodsPreviewPage(),
        RoutePaths.producerHome: (_) => const ProducerHomePage(),
        RoutePaths.producerEditor: (_) => const ProducerEditorPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
