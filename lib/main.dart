import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:storetools/const/routes.dart';
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
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (_) => const SplashPage(),
        Routes.login: (_) => const LoginPage(),
        Routes.home: (_) => const HomePage(),
        Routes.goods: (_) => const GoodsPage(),
        Routes.goodsEdit: (_) => const GoodsEditPage(),
        Routes.goodsPreview: (_) => const GoodsPreviewPage(),
        Routes.producerHome: (_) => const ProducerHomePage(),
        Routes.producerEditor: (_) => const ProducerEditorPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
